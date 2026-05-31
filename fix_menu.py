import os

def replace_beranda_menu(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        
    out_lines = []
    in_beranda_menu = False
    ul_depth = 0
    li_depth = 0
    
    i = 0
    while i < len(lines):
        line = lines[i]
        
        if not in_beranda_menu:
            # Check if this line is the start of the Beranda menu
            if '<li class="dropdown megamenu">' in line or '<li class="megamenu megamenu-clickable megamenu-clickable--toggler">' in line:
                # Let's peek ahead to see if it contains "Beranda"
                # Actually, the first megamenu is always Beranda.
                in_beranda_menu = True
                li_depth = 1
                
                # We replace it with a simple link
                out_lines.append('                              <li><a href="index.html">Beranda</a></li>\n')
            else:
                out_lines.append(line)
        else:
            # We are inside the Beranda menu, we need to track <li> and <ul> to find the end
            # Actually, tracking <li> is enough.
            # But wait, the start tag was already consumed. 
            # We just need to count <li and </li.
            
            li_depth += line.count('<li')
            li_depth -= line.count('</li')
            
            if li_depth <= 0:
                in_beranda_menu = False
                
        i += 1
        
    with open(filepath, 'w', encoding='utf-8') as f:
        f.writelines(out_lines)

html_dir = r"d:\gravity\gotur\gotur-html-main"
for filename in os.listdir(html_dir):
    if filename.endswith(".html"):
        replace_beranda_menu(os.path.join(html_dir, filename))
