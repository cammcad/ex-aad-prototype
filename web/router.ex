defmodule InterlineClient.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", InterlineClient do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
		get "/aad", PageController, :aad
		get "/aad/response", PageController, :aad_response
		get "/hellointerline", PageController, :call_secure_api
  end


  # Other scopes may use custom stacks.
  # scope "/api", InterlineClient do
  #   pipe_through :api
  # end
end
