Status.destroy_all
Status.create([
	{id: 0, description: "Reçu par le destinataire"},
	{id: 80, description: "Message bien envoyé"},
	{id: 201, description: "Generic failure d'un appareil"},
	{id: 202, description: "Attente de réseau d'un appareil"},
	{id: 203, description: "Null PDU"},
	{id: 210, description: "En attente de récupération par un téléphone portable" },
	{id: 211, description: "Récupéré par un téléphone portable - Envoi en attente"},
	{id: 215, description: "Le message est trop long et n'a pas pu être envoyé"}
	])
Client.where(id: 0).first && Client.destroy(0)
Client.create id: 0, name: "Super admin", email: "thomas@oxynum.fr", password: "I love Japan !", password_confirmation: "I love Japan !"
