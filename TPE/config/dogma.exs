use Mix.Config
alias Dogma.Rule

config :dogma,

  rule_set: Dogma.RuleSet.All,

  exclude: [~r(priv/repo/seeds.exs)],

  # Override an existing rule configuration
  override: [
    %Rule.LineLength{ max_length: 100 },
    %Rule.HardTabs{ enabled: false },
    %Rule.ModuleDoc{ enabled: false }
  ]
