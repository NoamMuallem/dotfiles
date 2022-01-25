local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("i","jk", "<esc>",opts)
keymap("i","kj", "<esc>",opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- map m anf M to ; and ,
keymap("n","m",";",opts)
keymap("n","M",",",opts)
keymap("v","m",";",opts)
keymap("v","M",",",opts)

-- Move to window using the <ctrl> movement keys
keymap("n","<C-h>", "<C-w>h",opts)
keymap("n","<C-j>", "<C-w>j",opts)
keymap("n","<C-k>", "<C-w>k",opts)
keymap("n","<C-l>", "<C-w>l",opts)

--jump list movement
keymap("n","<",'<C-o>',opts)
keymap("n",">",'<C-i>',opts)

--serouund text with prenthesis
keymap('v',"<Leader>'", " <esc>`>a'<esc>`<i'<esc>",opts)
keymap('v','<Leader>"', '<esc>`>a"<esc>`<i"<esc>',opts)
keymap('v',"<Leader>`", "<esc>`>a`<esc>`<i`<esc>",opts)
keymap('v',"<Leader>(", "<esc>`>a)<esc>`<i(<esc>",opts)
keymap('v',"<Leader>{", "<esc>`>a}<esc>`<i{<esc>",opts)
keymap('v',"<Leader>[", "<esc>`>a]<esc>`<i[<esc>",opts)

--insert new line without going into insert mode
keymap('n',"<leader>k",  ":<c-u>put!=repeat([''],v:count)<bar>']+1<cr>",opts)
keymap('n',"<leader>j",  ":<c-u>put =repeat([''],v:count)<bar>'[-1<cr>",opts)

--move lines and selected lines
keymap("n",'-', '"ldd$"lp',opts)
keymap("n",'_', '"ldd2k"lp',opts)
keymap("v",'_', ":'<,'> m '<-2<CR>gv",opts)
keymap("v",'-', ":'<,'> m '>+1<CR>gv",opts)

--yank visualy selected to clipboard
keymap("v","<Leader>y", '"*y',opts)

--open and close tabs woth leader n and leader N
keymap("n","<Leader>n" ,":tabnew<CR>",opts)
keymap("n","<Leader>N" ,":tabclose<CR>",opts)

-- Resize window using <ctrl> arrow keys
keymap("n","<S-Up>", ":resize +2<CR>",opts)
keymap("n","<S-Down>", ":resize -2<CR>",opts)
keymap("n","<S-Left>", ":vertical resize -2<CR>",opts)
keymap("n","<S-Right>", ":vertical resize +2<CR>",opts)

-- Clear search with <esc>
keymap("n","<esc>", ":noh<cr>",opts)

-- NOT WORKING: exit insert mode with jj
--keymap("i","jj", "<esc>",opts)

-- past from yank buffer
keymap("n","<Leader>P",'"0P',opts)
keymap("n","<Leader>p",'"0p',opts)
