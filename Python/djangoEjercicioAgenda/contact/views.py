from django.shortcuts import render
from .models import Contact
from .forms import ContactForm

# Create your views here.
def index(request):
    contacts = Contact.objects.filter(name__contains=request.GET.get('search', '')) # (valor de busqueda, valor por defecto), el valor por defecto es '' porque con este trae todos los elementos
    context = {
        'contacts': contacts
    }
    return render(request, 'contact/index.html', context)

def view(request, id):
    contact = Contact.objects.get(id=id)
    context = {
        "contact": contact
    }
    return render(request, "contact/detail.html", context)

def edit(request, id):
    if request.method == 'GET':
        contact = Contact.objects.get(id=id)
        form = ContactForm(instance=contact)
        context = {
            "form": form
        }
        return render(request, 'contact/create.html', context)