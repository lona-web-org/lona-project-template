from lona.view import LonaView
from lona.html import HTML, H1


class HomeView(LonaView):
    def handle_request(self, request):
        return HTML(
            H1('Hello World'),
        )
