from lona.routing import Route

routes = [
    Route('/', 'views/home.py::HomeView', name='home'),
]
