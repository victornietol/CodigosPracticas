from django.forms import ModelForm, DateInput
from .models import Todo

class TodoForm(ModelForm):
    class Meta:
        model = Todo
        fields = "__all__"
        widgets = {
            "estimated_end": DateInput(attrs={"type":"date"}),
            "date": DateInput(attrs={"type":"date"})
        }