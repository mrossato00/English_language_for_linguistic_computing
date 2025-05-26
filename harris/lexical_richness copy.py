from lexicalrichness import LexicalRichness
from pathlib import Path

# Define the folder path
folder_path = Path('/Users/marti/Documents/py/harris')

# Collect and concatenate all .txt file contents
all_text = ''
for file_path in folder_path.glob('*.txt'):
    with open(file_path, 'r', encoding='utf-8') as file:
        all_text += file.read() + '\n'  # Add newline between files for clarity

# Analyze combined text
lex = LexicalRichness(all_text)

# Print lexical richness metrics
print(f'Total files analyzed: {len(list(folder_path.glob("*.txt")))}')
print(f'TTR: {lex.ttr():.4f}')
print(f'MTLD: {lex.mtld():.4f}')
print(f'HDD: {lex.hdd():.4f}')
