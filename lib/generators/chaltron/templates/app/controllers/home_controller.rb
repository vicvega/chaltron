class HomeController < ApplicationController
  def index
    @faqs = []
    @faqs << {
      question: 'Non trovo abbastanza documentazione, che faccio?',
      answer: "Te la scrivi da solo, anzi sei caldamente invitato a farlo. Ho scritto un po'
       di pagine wiki, riguardanti in particolare
       <ul>
        <li><a href='#'>i grafici con chachacharts</a></li>
        <li><a href='#'>datatables</a></li>
      </ul>
      Aggiungi, modifica, migliora. Non posso fare tutto io."
    }
    @faqs << {
      question: 'Posso aggiungere questa cosa fichissima, utile e soprattutto scritta bene?',
      answer: "Certo, fai pure. E' tutto <a href='https://github.com/vicvega/chaltron'>qui</a>.
        E c'&egrave; parecchio da fare!"
    }
    @faqs << {
      question: 'Ma non si pu&ograve; fare che...?',
      answer: 'No!'
    }
    @faqs << {
      question: 'Questa cosa &egrave; fichissima. Come posso sdebitarmi?',
      answer: 'Un paio di birre vanno sempre bene.'
    }
  end
end
