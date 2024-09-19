import os
from fastapi import FastAPI, Request
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse
import uvicorn

app = FastAPI()

dirname = os.path.dirname(__file__)
templates_dir = os.path.join(dirname, "templates")
templates = Jinja2Templates(directory=templates_dir)

@app.get("/", response_class=HTMLResponse)
async def home(request: Request):
    return templates.TemplateResponse("home.html", {"request": request})

@app.get("/tab1", response_class=HTMLResponse)
async def tab1(request: Request):
    return templates.TemplateResponse("tab1.html", {"request": request})

@app.get("/tab2", response_class=HTMLResponse)
async def tab2(request: Request):
    return templates.TemplateResponse("tab2.html", {"request": request})

@app.get("/tab3", response_class=HTMLResponse)
async def tab3(request: Request):
    return templates.TemplateResponse("tab3.html", {"request": request})

if __name__ == "__main__":
    uvicorn.run("main:app", reload=False)
