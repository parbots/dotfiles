-- Neovide Configuration
if vim.g.neovide then
    -- General
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_theme = "dark"
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 5

    -- Cursor
    vim.g.neovide_cursor_animation_length = 0.10
    vim.g.neovide_cursor_trail_size = 0.2
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
end
