from .views import GenericAPIView
from django.urls import path


urlpatterns = [
    path('notes/', GenericAPIView.as_view()),
    path('notes/<int:id>/', GenericAPIView.as_view()),
]