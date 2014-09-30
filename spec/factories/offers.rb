FactoryGirl.define do
  factory :offer do
    trait :grugapark do
      name 'Grupapark'
      category 'Erlebnis, Spaß und Action'
      google_place_rating 4.5
      # description 'Mit etwa 60 ha einer der weiträumigsten und schönsten europäischen Stadtparks. Klein und Groß, Kulturfreunde, Botaniker oder Tierfreunde, Alleinstehende oder Familien nutzen die Möglichkeiten für eine aktive oder passive Erholung. Angebote: Hundertwasser- Haus; große Wasserflächen; Sport- und Spielplätze; attraktive Blumenbeete; bizarre Bergwelt mit Wasserfall; Irrgarten; Tropenhäuser in Glaspyramiden; Mediterraneum; Bauern-, Kräuter-, Rosengarten; Garten der Sinne; Mustergarten, Kurhaus mit Therme; ein Gradierwerk („Saline“); Kleintiergarten; 4.000 m² große Vogelfreifluganlage; Exoten-, Greifvogel- und Eulenvolieren; Damwildgehege; Ponybahn; wertvolle Kunstwerke; Pflanzen- und Kunstausstellungen; kulturelles Ganzjahresprogramm.'
      street 'Virchowstr. 167 a'
      city '45147 Essen'
      website 'www.grugapark.de'
      kind 'Eintritt frei'
      latitude 51.4317
      longitude 6.99055
      google_place_id 'ChIJmcKtLSLDuEcRnjYJRDiyUIE'
    end
    trait :kernie do
      name 'Kernie´s Familienpark im Wunderland Kalkar'
      category 'Halber Preis'
      google_place_rating 4.5
      # description 'Mit etwa 60 ha einer der weiträumigsten und schönsten europäischen Stadtparks. Klein und Groß, Kulturfreunde, Botaniker oder Tierfreunde, Alleinstehende oder Familien nutzen die Möglichkeiten für eine aktive oder passive Erholung. Angebote: Hundertwasser- Haus; große Wasserflächen; Sport- und Spielplätze; attraktive Blumenbeete; bizarre Bergwelt mit Wasserfall; Irrgarten; Tropenhäuser in Glaspyramiden; Mediterraneum; Bauern-, Kräuter-, Rosengarten; Garten der Sinne; Mustergarten, Kurhaus mit Therme; ein Gradierwerk („Saline“); Kleintiergarten; 4.000 m² große Vogelfreifluganlage; Exoten-, Greifvogel- und Eulenvolieren; Damwildgehege; Ponybahn; wertvolle Kunstwerke; Pflanzen- und Kunstausstellungen; kulturelles Ganzjahresprogramm.'
      street 'Griether Straße 110-120'
      city '47546 Kalkar'
      website 'www.wunderlandkalkar.eu'
      kind 'Halber Preis'
      latitude 51.763654
      longitude 6.3269163
      google_place_id 'ChIJQ7vUVeF7x0cR_VOTlnqMjPc'
    end
  end
end
