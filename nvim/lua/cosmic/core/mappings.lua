local map = require('cosmic.utils').map
-- map m anf M to ; and ,
map("n","m",";")
map("n","M",",")
map("v","m",";")
map("v","M",",")

-- Move to window using the <ctrl> movement keys
map("n","<C-h>", "<C-w>h")
map("n","<C-j>", "<C-w>j")
map("n","<C-k>", "<C-w>k")
map("n","<C-l>", "<C-w>l")

-- past from yank buffer
map("n","<Leader>P",'"0P')
map("n","<Leader>p",'"0p')

--overriding original customization for tab jumping
map("n","gt",'gt')
map("n","gT",'gT')

--jump list movement
map("n","<",'<C-o>')
map("n",">",'<C-i>')

--serouund text with prenthesis
map("v","<Leader>'", " <esc>`>a'<esc>`<i'<esc>")
map("v",'<Leader>"', '<esc>`>a"<esc>`<i"<esc>')
map("v","<Leader>`", "<esc>`>a`<esc>`<i`<esc>")
map("v","<Leader>(", "<esc>`>a)<esc>`<i(<esc>")
map("v","<Leader>{", "<esc>`>a}<esc>`<i{<esc>")
map("v","<Leader>[", "<esc>`>a]<esc>`<i[<esc>")

--insert new line without going into insert mode
map("n","<leader>k",  ":<c-u>put!=repeat([''],v:count)<bar>']+1<cr>")
map("n","<leader>j",  ":<c-u>put =repeat([''],v:count)<bar>'[-1<cr>")

--move lines and selected lines
map("n",'-', '"ldd$"lp')
map("n",'_', '"ldd2k"lp')
map("v",'_', ":'<,'> m '<-2<CR>gv")
map("v",'-', ":'<,'> m '>+1<CR>gv")

--exit insert mode with jj
map("i","jj", "<Esc>")

--yank visualy selected to clipboard
map("v","<Leader>y", '"*y')

--open and close tabs with leader n and leader N
map ("n","<Leader>n" ,":tabnew<CR>")
map ("n","<Leader>N" ,":tabclose<CR>")

-- Resize window using <ctrl> arrow keys
map("n","<S-Up>", ":resize +2<CR>")
map("n","<S-Down>", ":resize -2<CR>")
map("n","<S-Left>", ":vertical resize -2<CR>")
map("n","<S-Right>", ":vertical resize +2<CR>")

-- Clear search with <esc>
map("n","<esc>", ":noh<cr>")

-- Quickfix mappings
map('n', '<leader>ck', ':cexpr []<cr>')
map('n', '<leader>cc', ':cclose <cr>')
map('n', '<leader>co', ':copen <cr>')
map('n', '<leader>cf', ':cfdo %s/')
map('n', '<leader>cp', ':cprev<cr>zz')
map('n', '<leader>cn', ':cnext<cr>zz')

-- buffer navigation
map('n', '<leader>bp', ':bprev<cr>')
map('n', '<leader>bn', ':bnext<cr>')

map('n', '<C-n>', ':NvimTreeToggle<CR>')
map('n', '<leader>gg', '<cmd>Neogit<CR>')
map('n', '<leader>gd', '<cmd>DiffviewOpen<cr>')
