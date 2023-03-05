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
    print(matricule,password)
    query.set_action(sender_id, None)
    menus =[
            {"title":"Marihasina","subtitle":"Bienvenue Marihasina","pdp":"https://avatars.githubusercontent.com/u/80751503?s=400&u=6a0d04a90a1089e5ad180560b65371d56c0a20a8&v=4"},
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
    
@ampalibe.command("/is_authentified")
def is_authentified(sender_id,**extends):
    query.set_action(sender_id,None)
    quick_rep=[
        QuickReply(title="Poser une question🤔",payload=Payload('/get_answer',by='question')),
        QuickReply(title="Voir des reponses 🙌",payload=Payload('/get_answer',by='reponse')),
        QuickReply(title="Voir ampio app🤳🏼",payload=Payload('/get_answer',by='ampio_app'))
        ]
    chat.send_quick_reply(sender_id,quick_rep,"Que voulez-vous faire?😃 ")
    query.del_temp(sender_id, 'mat')

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
                    )
                ],
            ) for r in menus
        ]
        chat.send_generic_template(sender_id,elements, next=True)
    

@ampalibe.command('/checktypequestion')
def checktypequestion(sender_id,title,**extends):
    query.set_action(sender_id,None)
    chat.send_text(sender_id,f"Vous avez choisi de question une question de type 😃{title}")
    if title=='Text':
        chat.send_text(sender_id,"Posez ici votre question pour que les autres membre puissent le voir🙏")
        query.set_action(sender_id,'/get_simple_question')
    elif title=='Avec_fichier':
        chat.send_text(sender_id,"Posez ici la question, et n'oublies pas de joindre votre fichier 🙏")
        query.set_action(sender_id,'/get_with_fic')
    elif title=="Fichier_seulement":
        chat.send_text(sender_id,"Glissez ici votre fichier 🙏")
        query.set_action(sender_id,'/get_fic_only')

@ampalibe.action('/get_simple_question')
def get_simple_question(sender_id,cmd,**extends):
    query.set_temp(sender_id, 'question', cmd)
    chat.send_text(sender_id,"Question bien anvoyé 👍")
    quick_rep=[
        QuickReply(title="Oui🤝",payload=Payload('/is_authentified',by='question')),
        QuickReply(title="Non🙂",payload=Payload('/is_authentified',by='autre')),
       
    ]
    chat.send_quick_reply(sender_id,quick_rep,"Vous voulez autre chose?😃 ")

@ampalibe.action('/get_with_fic')
def get_simple_question(sender_id,cmd,**extends):
    query.set_temp(sender_id, 'question', cmd)
    chat.send_text(sender_id,"Question bien anvoyé 👍")
    quick_rep=[
        QuickReply(title="Oui🤝",payload=Payload('/is_authentified',by='question')),
        QuickReply(title="Non🙂",payload=Payload('/is_authentified',by='autre')),
       
    ]
    chat.send_quick_reply(sender_id,quick_rep,"Vous voulez autre chose?😃 ")
@ampalibe.action('/get_fic_only')
def get_simple_question(sender_id,cmd,**extends):
    query.set_temp(sender_id, 'question', cmd)
    chat.send_text(sender_id,"Question bien anvoyé 👍")
    quick_rep=[
        QuickReply(title="Oui🤝",payload=Payload('/is_authentified',by='question')),
        QuickReply(title="Non🙂",payload=Payload('/is_authentified',by='autre')),
       
    ]
    chat.send_quick_reply(sender_id,quick_rep,"Vous voulez autre chose?😃 ")

    




     








