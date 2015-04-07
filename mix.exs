defmodule InterlineClient.Mixfile do
  use Mix.Project

  def project do
    [app: :interlineClient,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {InterlineClient, []},
     applications: [:phoenix, :cowboy, :logger, :httpotion],
		 env: [clientid: "client-id-here",
					 clientsecret: "client-secret-here",
					 redirectUri: "redirect-uri-here",
					 azureAD_resource: "azure-active-directory-resource-here",
					 accessToken_endpoint: "access-token-endpoint-here"]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.10.0"},
     {:phoenix_ecto, "~> 0.1"},
     {:postgrex, ">= 0.0.0"},
     {:cowboy, "~> 1.0"},
		 {:uuid, "~> 1.0"},
		 {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.1"},
		 {:exjsx, github: "talentdeficit/exjsx", tag: "v3.1.0"},
		 {:httpotion, "~> 2.0.0"}]
  end
end
