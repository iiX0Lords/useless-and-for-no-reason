import os
import subprocess

if __name__ == "__main__":
    script_dir = os.path.dirname(os.path.abspath(__file__))
    game_root = os.path.dirname(script_dir)

    love_exe = os.path.join(game_root, "love2d", "love.exe")
    game_path = os.path.join(game_root, "game")

    if not os.path.isfile(love_exe):
        raise FileNotFoundError(f"Love can't be found at: {love_exe}")
    if not os.path.isdir(game_path):
        raise FileNotFoundError(f"Can't find Love game folder at: {game_path}")

    subprocess.Popen([love_exe, game_path]).wait()