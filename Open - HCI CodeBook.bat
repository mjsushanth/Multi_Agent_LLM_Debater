@echo off
REM Set the path to your Anaconda installation
set CONDA_PATH=C:\Users\joems\miniconda3

REM Set your environment name
set ENV_NAME=debate-env

REM Set the target path
set TARGET_PATH="D:\JoelDesktop folds_24\NEU SPRING25 - DL, HCI\Projects\Multi-Agent LLM Debator"

REM Change to the target directory
cd /d %TARGET_PATH%

REM Activate Conda
call %CONDA_PATH%\Scripts\activate.bat

REM Activate the specific environment
call conda activate %ENV_NAME%

REM Launch Jupyter Notebook
jupyter lab "MultiLLM Debate.ipynb"

REM Keep the window open
cmd /k