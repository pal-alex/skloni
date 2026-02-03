project_root = File.cwd!()
mnesia_dir = Application.fetch_env!(:mnesia, :dir) |> List.to_string()
mnesia_path = Path.expand(mnesia_dir, project_root)
expected_root = Path.expand("priv/mnesia", project_root)

if String.starts_with?(mnesia_path, expected_root) do
  File.rm_rf!(mnesia_path)
end

_ = Skloni.Mnesia.start()
_ = Skloni.Mnesia.stop()

ExUnit.start()
