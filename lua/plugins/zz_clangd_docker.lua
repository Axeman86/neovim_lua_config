-- rename zz_xxx.lua, 是因为要在 lang.lua 之后加载，覆盖 clangd 的配置
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local host_ws = (os.getenv("HOME") or "/home/axeman") .. "/Workspace/qyun_ws"
      local container_ws = "/home/qyun/qyun_ws"
      local clangd = opts.servers.clangd
      local host_cmd = vim.deepcopy(clangd.cmd or { "clangd" })

      clangd.cmd = function(dispatchers, config)
        local root = config.root_dir or ""
        local in_workspace = root == host_ws or vim.startswith(root, host_ws .. "/")

        local cmd = host_cmd
        if in_workspace then
          cmd = {
            "docker",
            "exec",
            "-i",
            "-w",
            container_ws,
            "qyun_env_iron",
            "clangd",
            "--background-index",
            "--path-mappings=" .. host_ws .. "=" .. container_ws,
          }
        end

        return vim.lsp.rpc.start(cmd, dispatchers, {
          cwd = config.cmd_cwd,
          env = config.cmd_env,
          detached = config.detached,
        })
      end
    end,
  },
}
