#!/usr/bin/env python3
"""
Archive Manager - Handles the immutability logic for 'Mente Brilhante Ω'
"""

import shutil
from pathlib import Path
from datetime import datetime

def archive_file(source_path: Path, archive_dir: Path, version: str, suffix: str = ""):
    try:
        if not source_path.exists():
            print(f"❌ [ERRO] Arquivo fonte não encontrado: {source_path}")
            return False

        archive_dir.mkdir(parents=True, exist_ok=True)
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        dest_name = f"{source_path.stem}_{suffix}_v{version}_{timestamp}{source_path.suffix}"
        dest_path = archive_dir / dest_name

        shutil.copy2(source_path, dest_path)
        print(f"✅ [SUCESSO] Arquivado: {source_path.name} -> {dest_path.name}")
        return True
    except Exception as e:
        print(f"❌ [ERRO] Falha ao arquivar arquivo: {e}")
        return False

def archive_directory(source_dir: Path, archive_root: Path, version: str):
    try:
        if not source_dir.exists():
            print(f"⚠️ [AVISO] Diretório fonte não existe, pulando: {source_dir}")
            return False

        timestamp = datetime.now().strftime("%Y%m%d")
        dest_dir = archive_root / f"spec_v{version}_{timestamp}"

        if dest_dir.exists():
            shutil.rmtree(dest_dir) # Garante que não haverá conflito se rodar no mesmo dia

        shutil.copytree(source_dir, dest_dir)
        print(f"✅ [SUCESSO] Diretório arquivado: {source_dir.name} -> {dest_dir.name}")
        return True
    except Exception as e:
        print(f"❌ [ERRO] Falha ao arquivar diretório: {e}")
        return False

if __name__ == "__main__":
    import sys
    # Example usage: archive_manager.py sprint CURRENT_SPRINT.md 1.0.0
    if len(sys.argv) < 4:
        sys.exit(1)

    action = sys.argv[1]
    path = Path(sys.argv[2])
    version = sys.argv[3]
    archive_root = Path(".agile/history/archive")

    if action == "sprint":
        archive_file(path, archive_root, version, "SPRINT")
    elif action == "roadmap":
        archive_file(path, archive_root, version, "ROADMAP")
    elif action == "specs":
        archive_directory(path, archive_root, version)
