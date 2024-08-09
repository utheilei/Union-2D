from http.server import HTTPServer, BaseHTTPRequestHandler
import json
from chatterbot import ChatBot
from chatterbot.trainers import ChatterBotCorpusTrainer
 
class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/chatrobot':
            self.do_chatrobot()
        else:
            self.do_default()

    def do_chatrobot(self):
        res = "Please use post, url:/api/v1/chatrobot"
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        message = "'result': '%s'" % res
        message_str = json.dumps(message)
        self.wfile.write(message_str.encode())

    def do_default(self):
        self.send_error(404, 'URL is not supported')
 
    def do_POST(self):
        if self.path == '/api/v1/chatrobot':
            # 读取POST数据
            content_length = int(self.headers.get('Content-Length', 0))
            post_data = self.rfile.read(content_length)
            parseOK = True
            try:
                result = json.loads(post_data)
            except json.JSONDecodeError:
                parseOK = False
                print("JSONDecodeError")
            # 响应POST请求
            code = 200
            if not parseOK:
                code = 400
            self.send_response(code)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            body = result["body"]
            print("body:", body)
            response = bot.get_response(body)
            message = "'result': '%s'" % response
            message_str = json.dumps(message)
            self.wfile.write(message_str.encode())
        else:
            self.do_default()
 
if __name__ == '__main__':
    bot = ChatBot('MyBot')
    # 初始化训练器
    trainer = ChatterBotCorpusTrainer(bot)
    # 使用中文语料库进行训练
    trainer.train("chatterbot.corpus.chinese")
    httpd = HTTPServer(('localhost', 8000), SimpleHTTPRequestHandler)
    print("Serving at http://localhost:8000")
    httpd.serve_forever()