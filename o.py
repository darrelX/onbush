import fitz  # PyMuPDF

def modifier_pdf(chemin_pdf, ancien_texte, nouveau_texte, chemin_sortie):
    doc = fitz.open(chemin_pdf)
    for page in doc:
        zones = page.search_for(ancien_texte)
        for zone in zones:
            # Couvre l'ancien texte
            page.add_redact_annot(zone, fill=(1, 1, 1))  # blanc
        page.apply_redactions()

        # Remet le nouveau texte à l'endroit de l'ancien
        for zone in zones:
            x, y = zone[:2]
            page.insert_text((x, y), nouveau_texte, fontname="helv", fontsize=12, color=(0, 0, 0))
    
    doc.save(chemin_sortie)
    doc.close()
    
modifier_pdf("ezekielle.pdf", "Darrel Foweng Tcho", "GUETCHUENG MAKAM Ashley Ezekiele", "ezekielle_modifie.pdf")