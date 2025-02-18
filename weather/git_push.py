import os
import subprocess
from datetime import datetime

# Configura il percorso della cartella e il repository remoto
FOLDER_PATH = "C://Users//User//Documents//GitHub"
REMOTE_REPO = "git@github.com:https://github.com/LorenzoUnich/Programmi_da_usare"  # Usa il formato HTTPS o SSH

def run_command(command, cwd=None):
    """Esegue un comando nella shell e restituisce l'output."""
    result = subprocess.run(command, shell=True, cwd=cwd, text=True, capture_output=True)
    if result.returncode != 0:
        print(f"Errore: {result.stderr}")
        raise Exception(f"Comando fallito: {command}")
    return result.stdout.strip()

def git_commit_push(folder_path, remote_repo):
    """Committa e push una cartella su GitHub."""
    try:
        # Controlla se la cartella è un repository Git
        if not os.path.exists(os.path.join(folder_path, ".git")):
            print("Inizializzo il repository Git...")
            run_command("git init", cwd=folder_path)
            run_command(f"git remote add origin {remote_repo}", cwd=folder_path)

        # Aggiungi tutti i file al repository
        print("Aggiungo i file al repository...")
        run_command("git add .", cwd=folder_path)

        # Crea un commit con un messaggio dinamico
        commit_message = f"Commit automatico - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
        print(f"Committo con messaggio: {commit_message}")
        run_command(f'git commit -m "{commit_message}"', cwd=folder_path)

        # Esegui il push al repository remoto
        print("Eseguo il push al repository remoto...")
        run_command("git push -u origin main", cwd=folder_path)

        print("Push completato con successo!")
    except Exception as e:
        print(f"Errore durante il processo: {e}")

# Esegui la funzione
git_commit_push(FOLDER_PATH, REMOTE_REPO)
