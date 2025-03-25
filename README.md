# GDis-transcribe

This is an HTTP wrapper for [SYSTRAN's Faster Whisper Python implementation](https://github.com/SYSTRAN/faster-whisper/tree/master)

It is intended to be used with [GDis-server](https://github.com/SquirrelsMcGee/GDis-server) but can be used on it's own

# Setup
These steps assume you have some python knowledge. Please search online for help if you get stuck, raise an issue if you really need it.

1. Ensure you have python installed (I'm using 3.10.6)
2. Install dependencies, [PyTorch](https://pytorch.org/get-started/locally/), [fastapi](https://fastapi.tiangolo.com/tutorial/), [faster-whisper](https://fastapi.tiangolo.com/tutorial/)
3. Run using `run.ps1` or `uvicorn main:app --reload --port 5005`

> Note port 5005 is the default used by GDis
