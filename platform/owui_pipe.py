class Pipe:
    def __init__(self):
        pass

    def _contains_file(self, body: dict) -> bool:
        print("-------------BODY----------------")
        print(body)
        print("-------------BODY----------------")
        return True

    def _needs_parsing(self, file_type: dict) -> bool:
        pass

    def _parse_file(self, file: dict) -> str:
        pass

    def _md_to_messages(self, md_content: str) -> list:
        pass


    def pipe(self, body: dict):
        # 1. Determine if response contains file
        # 2. Determine if file needs to be parsed by docling
        # 3.1 If yes, transform to md using docling
        # 3.2 Convert md into messages json
        # 4. Send messages to chat/completion endpoint
        # 5. Catch possible context window excceed errors
        # 6. Return either error or reponse as stream

        if self._contains_file(body):
            pass

        raise NotImplementedError("This is a stub implementation.")