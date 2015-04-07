defmodule InterlineClient.PageController do
  use InterlineClient.Web, :controller
	
  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  @moduledoc """
  Redirects browser to authenticate via Azure Active Directory (interlineWebApp). 
  """
  def aad(conn, _params) do
	redirectUri = "https://login.windows.net/common/oauth2/authorize?response_type=code&
                                client_id=#{Application.get_env(:interlineClient,:clientid)}&
                                resource=#{Application.get_env(:interlineClient,:azureAD_resource)}&
                                redirect_uri=#{Application.get_env(:interlineClient, :redirectUri)}&
                                state=#{UUID.uuid1()}"
	redirect conn, external: redirectUri
  end
	
  @moduledoc """
  Callback handler for Azure Active Directory Authentication.
  Azure should be providing the generated authorization code 
  """
  def aad_response(conn, %{ "code" => code, "state" => _state, "session_state" => _session_state}) do
	redeem_authorizationCode_for_access_token(conn,code)
  end

  @moduledoc """
  Sends an http request (POST - for an access token) to Azure Active Directory.
  This sends the generated authorization code back to Azure AD in exchange for 
  a generated temporary access token.
  """
  defp redeem_authorizationCode_for_access_token(conn,code) do
	postUri  = Application.get_env(:interlineClient,:accessToken_endpoint)
	response = HTTPotion.post postUri, [body: "grant_type=authorization_code&
                                             code=#{code}&
                                             client_id=#{Application.get_env(:interlineClient,:clientid)}&
                                             redirect_uri=#{Application.get_env(:interlineClient, :redirectUri)}&
                                             client_secret=#{Application.get_env(:interlineClient, :clientsecret)}",
					    headers: ["content-type": "application/x-www-form-urlencoded"]]
	IO.puts (HTTPotion.Response.success?(response)) # debug output
	%HTTPotion.Response{body: body, headers: _, status_code: _statusCode} = response
	access_token_params = JSX.decode body
	{:ok,%{"access_token" => token, "expires_in" => _ein, "expires_on" => _eon, "id_token" => _id_token,
		"not_before" => _nb, "pwd_exp" => _pwd_exp, "pwd_url" => _pwd_url, "refresh_token" => _refresh_token,
		"resource" => _res, "scope" => _scope, "token_type" => token_type}} = access_token_params
	send_resp(conn,200,"access_token:#{token}, token_type:#{token_type}")
  end
end
