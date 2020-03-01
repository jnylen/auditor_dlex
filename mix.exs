defmodule AuditorDlex.MixProject do
  use Mix.Project

  @name :auditor_dlex
  @version "0.1.0"
  @deps [
    {:auditor, "~> 0.1.0"}
  ]

  def project do
    [
      app: @name,
      version: @version,
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: @deps
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {AuditorDlex.Application, []}
    ]
  end
end
