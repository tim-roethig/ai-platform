file_path = 

with open(file_path, "rb") as f:
    files = {"files": (file_path, f, "application/octet-stream")}