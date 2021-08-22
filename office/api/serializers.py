from rest_framework import fields, serializers
from .models import Note

class NoteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Note
        #fields = ['id','title','content', 'date']
        fields = '__all__'

