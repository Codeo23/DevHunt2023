import ampalibe
from ampalibe import Messenger,Payload,Model
from ampalibe.ui import QuickReply,Element,Button
from model import UserModel
from ampalibe.messenger import Action,Filetype
from conf import Configuration as config

chat = Messenger()
users = UserModel()
query = Model()

@ampalibe.command('/')
def main(sender_id, cmd, **ext):
    chat.send_text(sender_id, "Salut👋,Bienvenue chez Ampio😀")
    quick_rep=[
        QuickReply(title="🇫🇷Français",payload=Payload('/chooselangue',by='français')),
        QuickReply(title="🇬🇧English",payload=Payload('/chooselangue',by='anglais')),
        QuickReply(title="🇲🇬Malagasy",payload=Payload('/chooselangue',by='malagasy'))
    ]
    chat.send_quick_reply(sender_id,quick_rep,"Veuillez choisir votre langue 🌏")
@ampalibe.command('/chooselangue')
def chooselangue(sender_id, by,**extends):
    query.set_action(sender_id, None)
    chat.send_text(sender_id,f"Votre langue actuel est : {by}")
    chat.send_file_url(
        sender_id,
        "https://github.com/hasina821/Avaizo/blob/master/ampio.png?raw=true",
         filetype=Filetype.image
    )
    chat.send_text(sender_id, "Ampio est une application de partage seulement pour les etudiants de l'ENI")
    quick_rep=[
        QuickReply(title="👍Oui",payload=Payload('/chosetolog',by='oui')),
        QuickReply(title="👎Non",payload=Payload('/chosetolog',by='non'))
    ]
    chat.send_quick_reply(sender_id,quick_rep,"Vous voulez continuer 😀?")

@ampalibe.command('/chosetolog')
def choselog(sender_id,by,**extends):
    if(by=="oui"):
        chat.send_text(sender_id,"Cool👊🏼,mais authentifiez-vous d'abord😃")
        chat.send_text(sender_id, 'Entrer votre matricule🔢')
        query.set_action(sender_id,'/get_matricule')
    
@ampalibe.action('/get_matricule')
def get_mail(sender_id, cmd, **ext):
    query.set_temp(sender_id, 'mat', cmd)
    chat.send_text(sender_id, f'Entrer votre mot de passe🔑 ')
    query.set_action(sender_id, '/get_password')

@ampalibe.action('/get_password')
def get_password(sender_id, cmd, **extends):
    matricule = query.get_temp(sender_id, 'mat')
    password = cmd
    data = users.getOneUser(matricule)
    global author_id
    author_id = data[0]
    if(data!= None):
        query.set_action(sender_id, None)
        menus =[
                {"title":f"{data[3]}","subtitle":f"Bienvenue {data[3]}","pdp":f"https://1223-197-149-23-165.ngrok.io/api/users/{data[0]}/avatar"},
            ]
        elements=[
            Element(
                title=r['title'],
                subtitle=r['subtitle'],
                image_url=r['pdp'],
                buttons=[
                    Button(
                        type="postback",
                        title="Continuer",
                        payload=Payload('/is_authentified',title=r['title'])
                    )
                ],
            ) for r in menus
        ]
        chat.send_generic_template(sender_id,elements, next=True)
    else:
        query.set_action(sender_id, "/get_password")
    
    
@ampalibe.command("/is_authentified")
def is_authentified(sender_id,**extends):
    query.set_action(sender_id,None)
    quick_rep=[
        QuickReply(title="Poser une question🤔",payload=Payload('/get_answer',by='question')),
        QuickReply(title="Voir des reponses 🙌",payload=Payload('/get_answer',by='reponse')),
        QuickReply(title="Voir ampio app🤳🏼",payload=Payload('/get_answer',by='ampio_app'))
        ]
    chat.send_quick_reply(sender_id,quick_rep,"Que voulez-vous faire?😃 ")

@ampalibe.command('/get_answer')
def get_answer(sender_id ,by,**extends):
    query.set_action(sender_id,None)
    if(by=="question"):
        menus =[
            {"title":"Text","subtitle":"Question de type text","pdp":"https://3dicons.sgp1.cdn.digitaloceanspaces.com/v1/dynamic/premium/text-dynamic-premium.png"},
            {"title":"Avec_fichier","subtitle":"Question avec des fichiers","pdp":"https://3dicons.sgp1.cdn.digitaloceanspaces.com/v1/dynamic/premium/copy-dynamic-premium.png"},
            {"title":"Fichier_seulement","subtitle":"Question avec un fichier seulement","pdp":"https://3dicons.sgp1.cdn.digitaloceanspaces.com/v1/dynamic/premium/folder-dynamic-premium.png"},
        ]
        elements=[
            Element(
                title=r['title'],
                subtitle=r['subtitle'],
                image_url=r['pdp'],
                buttons=[
                    Button(
                        type="postback",
                        title="Choisir",
                        payload=Payload('/checktypequestion',title=r['title'])
                    ),
                ],
            ) for r in menus
        ]
        chat.send_generic_template(sender_id,elements, next=True)
    
@ampalibe.command('/checktypequestion')
def checktypequestion(sender_id,title,**extends):
    query.set_action(sender_id,None)
    chat.send_text(sender_id,f"Vous avez choisi de question une question de type 😃{title}")
    if title=='Text':
        chat.send_text(sender_id,"Posez ici le titre de votre question🙏")
        query.set_action(sender_id,'/get_simple_question_title')
    elif title=='Avec_fichier':
        chat.send_text(sender_id,"Posez ici le titre de votre question 🙏")
        query.set_action(sender_id,'/get_with_fic_title')
    elif title=="Fichier_seulement":
        chat.send_text(sender_id,"Glissez ici votre fichier 🙏")
        query.set_action(sender_id,'/get_fic_only')


'''simple question'''

@ampalibe.action('/get_simple_question_title')
def get_simple_question(sender_id,cmd,**extends):
    query.set_temp(sender_id, 'title', cmd)
    chat.send_text(sender_id,"Veuilez saisir ici le contenu de votre question🙂")
    query.set_action(sender_id,"/get_simple_question_itself")
    

@ampalibe.action('/get_simple_question_itself')
def get_simple_question(sender_id, cmd,**extends):
    query.set_action(sender_id,None)
    contenu = cmd
    try:
        titre = query.get_temp(sender_id, 'title')
        users.postPost(str(titre),str(contenu),author_id)
        chat.send_text(sender_id,"Question bien posté🔥")
        quick_rep=[
            QuickReply(title="Oui🤝",payload=Payload('/is_authentified',by='question')),
            QuickReply(title="Non🙂",payload=Payload('/is_authentified',by='autre')),
        ]
        chat.send_quick_reply(sender_id,quick_rep,"Vous voulez autre chose?😃 ")
    except:
        query.set_action(sender_id,"/get_simple_question_title")
    query.del_temp(sender_id, 'title')




@ampalibe.action('/get_with_fic_title')
def get_simple_question(sender_id,cmd,**extends):
    query.set_temp(sender_id, 'titre_fic', cmd)
    chat.send_text(sender_id,"Veuilez saisir ici le contenu de votre question🙂")
    query.set_action(sender_id,"/get_with_fic_contenu")
   
@ampalibe.action('/get_with_fic_contenu')
def get_simple_question(sender_id, cmd,**extends):
    query.set_temp(sender_id, 'cont_fic', cmd)
    chat.send_text(sender_id,"Glissez maintenant votre fichier🙂")
    query.set_action(sender_id,"/get_with_fic_itself")

@ampalibe.action('/get_with_fic_itself')
def get_simple_question(sender_id, cmd,**extends):
    query.set_action(sender_id,None)
    titre = query.get_temp(sender_id, 'titre_fic')
    contenu = query.get_temp(sender_id, 'cont_fic')
    fichier = cmd
    try:
        users.postPostFic(str(titre),str(contenu),str(fichier),author_id)
        chat.send_text(sender_id,"Question bien posté🔥")
        quick_rep=[
            QuickReply(title="Oui🤝",payload=Payload('/is_authentified',by='question')),
            QuickReply(title="Non🙂",payload=Payload('/saygoodbye',by='autre')),
        ]
        chat.send_quick_reply(sender_id,quick_rep,"Vous voulez autre chose?😃 ")
    except:
        query.set_action(sender_id,"/get_simple_question_title")
    


@ampalibe.action('/get_fic_only')
def get_simple_question(sender_id,cmd,**extends):
    query.set_action(sender_id,None)
    print(cmd)
    """
    query.set_temp(sender_id, 'question', cmd)
    chat.send_text(sender_id,"Question bien anvoyé 👍")
    quick_rep=[
        QuickReply(title="Oui🤝",payload=Payload('/is_authentified',by='question')),
        QuickReply(title="Non🙂",payload=Payload('/is_authentified',by='autre')),
       
    ]
    chat.send_quick_reply(sender_id,quick_rep,"Vous voulez autre chose?😃 ")
    """
@ampalibe.command('/saygoodbye')
def saygoodbye(sender_id,by,**extends):
    query.set_action(sender_id,None)
    chat.send_message(sender_id,"Au revoir🥺 et merci de votre visite👋")










