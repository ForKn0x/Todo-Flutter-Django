from django.shortcuts import render
from .models import Note
from .serializers import NoteSerializer
from rest_framework.views import APIView
from rest_framework import generics, mixins
# Create your views here.

class GenericAPIView(generics.GenericAPIView, mixins.CreateModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin, mixins.RetrieveModelMixin, mixins.ListModelMixin):
    serializer_class = NoteSerializer
    queryset = Note.objects.all()

    lookup_field = 'id'

    def get(self, request, id = None):

        if id:
            return self.retrieve(request)
        else:
            return self.list(request)

    def post(self, request):
        return self.create(request)

    def put(self, request, id):
        return self.update(request, id)

    def delete(self, request, id):
        return self.destroy(request, id)


