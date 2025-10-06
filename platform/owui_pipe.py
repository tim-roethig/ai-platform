# Pipeline Docs: https://docs.openwebui.com/features/plugin/functions/pipe
# Pipeline Special Args: https://docs.openwebui.com/tutorials/tips/special_arguments

import requests

class Pipe:
    def __init__(self):
        self.docling_url = "http://docling:5001"

    def _contains_file(self, files: list) -> bool:
        return len(files) > 0

    def _parse_file(self, file: dict) -> str:
        print(1)
        files = {"files": (file["file"]["meta"]["name"], open(file["file"]["path"], "rb"), file["file"]["meta"]["content_type"])}
        data = {
            "target_type": "inbody",
            "to_formats": ["md"],
            "image_export_mode": "embedded",
            "do_ocr": False,
            "force_ocr": False,
            "table_mode": "accurate",
            #"table_cell_matching": True,
            "pipeline": "standard",
            "document_timeout": 600,
            "abort_on_error": True,
            "do_table_structure": True,
            "include_images": True,
            "images_scale": 1.0,
            "do_code_enrichment": False,
            "do_formula_enrichment": False,
            "do_picture_classification": False,
            "do_picture_description": False,
        }
        print(2)
        
        response = requests.post(
            f"{self.docling_url}/v1/convert/file",
            files=files,
            data=data
        )
        print(3)
        print("-------------RESPONSE----------------")
        print(response)
        markdown_content = response.json()["document"]["md_content"]
        print(markdown_content)
        print("-------------RESPONSE----------------")

        return markdown_content

    def _md_to_messages(self, md_content: str) -> list:
        pass


    def pipe(self, body: dict, __files__: list):
        # 1. Determine if response contains file
        # 2. Determine if file needs to be parsed by docling
        # 3.1 If yes, transform to md using docling
        # 3.2 Convert md into messages json
        # 4. Send messages to chat/completion endpoint
        # 5. Catch possible context window excceed errors
        # 6. Return either error or reponse as stream
        print("-------------FILES----------------")
        print(__files__)
        print("-------------FILES----------------")
        print("-------------BODY----------------")
        print(body)
        print("-------------BODY----------------")

        if self._contains_file(__files__):
            md = self._parse_file(__files__[0])

        return md