pragma solidity ^0.4.23;

import ".././produitaccesscontrol/ProducteurRole.sol";
import ".././produitaccesscontrol/DistributeurRole.sol";
import ".././produitaccesscontrol/VendeurRole.sol";
import ".././produitaccesscontrol/ClientRole.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";


contract SupplyChain is ProducteurRole, DistributeurRole, VendeurRole, ClientRole, Ownable {

    address deployer;
    address emptyAddress = 0x00000000000000000000000000000000000000;

    struct Location {
        string latitude;
        string longitude;
        string locationAddress;
    }

    struct Champs {
        uint idChamps;
        string nomChamps;
        Location location;
    }

      mapping (uint => Champs) public champs;
        uint public champsCount;

        mapping (uint => Location) public champLocation;
        uint public locationsCount;


        event ChampsRegistered(uint idChamps);

        enum Cultivateur {Planter, Recolter, Emballer}
        struct ProduitRiz {
       uint idRiz;
       string nomriz;
       uint dateplantation;
       address addresseChamps;
       Cultivateur region;
       Champs champs;
   }


       mapping (uint => ProduitRiz) public produitRiz;
       uint public produitRizCount;

       event RizPlanter(uint idRiz);
       event RizRecolter(uint idRiz);
       event RizEmballer(uint idRiz);

       enum EtatRiz {Packed, ForDistributionSold, ShippedRetail, ForSale,  Sold, Shipped, Received, Consumed}

       struct SacRiz {
           uint idSac;
           ProduitRiz produitRiz;
           uint prix;
           EtatRiz etatRiz;
           address acheteur;
           address proprietaireRiz;
           string nomProducteur;
       }
       mapping (uint => SacRiz) public sacs;
          uint public sacsCount;

          event SacRizPacked(uint idSac);
          event SacRizForDistributionSold(uint idSac);
          event SacRizShippedRetail(uint idSac);
          event RizSacForSale(uint idSac);
          event RizSacRizSold(uint idSac);
          event SacRizShipped(uint idSac);
          event SacRizReceived(uint idSac);

          modifier verifyCaller(address _address) {
              require(msg.sender == _address, " Ne peut verifier ");
              _;
          }

          modifier produitRizExists(uint idRiz) {
                  require(produitRiz[idRiz].idRiz > 0, "il ny a pas de riz");
                  _;
              }

              modifier verifyCultivateur(uint _idRiz, Cultivateur region) {
                  require(produitRiz[_idRiz].region == region, "ne peut verifier letat du riz");
                  _;
              }

              modifier SacRizExists(uint idSac) {
                  require(sacs[idSac].idSac > 0, "le sac de riz existe pas");
                  _;
              }

              modifier verifyEtatRiz(uint idSac, EtatRiz etatRiz) {
                  require(sacs[idSac].etatRiz == etatRiz, "etat du sac de riz ne peut etre verifie");
                  _;
              }

              modifier isPaidEnough(uint prix) {
                  require(msg.value >= prix, "argent manquant");
                  _;
              }

                  modifier returnExcessChange(uint idSac) {

                      uint prix = sacs[idSac].prix;
                      uint excessChange = msg.value - prix;
                      sacs[idSac].acheteur.transfer(excessChange);
                        _;
                  }

                  constructor() public {
       deployer = msg.sender;
   }


   function kill() public onlyOwner {
       if (msg.sender == deployer) {
           selfdestruct(deployer);
       }
   }

   function enregistrerChamps(uint idChamps, string _nomChamps, string _champLatitude, string _champLongitude, string _locationAddress) public {



       Location storage newLocation = champLocation[idChamps];
       newLocation.latitude = _champLatitude;
       newLocation.longitude = _champLongitude;
       newLocation.locationAddress = _locationAddress;

       Champs storage newChamps = champs[idChamps];
       newChamps.idChamps = idChamps;
       newChamps.nomChamps = _nomChamps;
       newChamps.location = newLocation;

       emit ChampsRegistered(idChamps);

   }

   function getChampsInfo(uint _idChamps) public view
    returns (uint idChamps, string nomChamps, string latitude, string longitude, string locationAddress) {
        Champs storage returnChamps = champs[_idChamps];
        idChamps = returnChamps.idChamps;
        nomChamps = returnChamps.nomChamps;
        latitude = returnChamps.location.latitude;
        longitude = returnChamps.location.longitude;
        locationAddress = returnChamps.location.locationAddress;
    }


    function planterRiz(uint idRiz, string _nomriz, uint _dateplantation,  uint idChamps) public onlyProducteur {

       ProduitRiz storage newProduitRiz = produitRiz[idRiz];
       newProduitRiz.idRiz = idRiz;
       newProduitRiz.nomriz = _nomriz;
       newProduitRiz.dateplantation = _dateplantation;
       //newProduitRiz.nombreIntrant = _nombreintrant;
       newProduitRiz.addresseChamps = msg.sender;
       newProduitRiz.region = Cultivateur.Planter;
       newProduitRiz.champs = champs[idChamps];

       emit RizPlanter(idRiz);
   }


   function recolterRiz(uint noRiz) public
    produitRizExists(noRiz)
    verifyCultivateur(noRiz, Cultivateur.Planter)
    verifyCaller(produitRiz[noRiz].addresseChamps)
    onlyProducteur {

        produitRiz[noRiz].region = Cultivateur.Recolter;

        emit RizRecolter(noRiz);
    }

    function emballerRiz(uint noRiz) public
    produitRizExists(noRiz)
    verifyCultivateur(noRiz, Cultivateur.Recolter)
    verifyCaller(produitRiz[noRiz].addresseChamps)
    onlyProducteur {

        produitRiz[noRiz].region = Cultivateur.Emballer;

        emit RizEmballer(noRiz);
    }

    function getProduitRizInfo(uint noRiz) public view
   returns (uint idRiz,
            string nomriz,
            uint dateplantation,
            string region,
            uint idChamps,
            string nomChamps,
            string latitudeChamps,
            string longitudeChamps,
            string locationAddressChamps) {

       idRiz = noRiz;
       ProduitRiz storage newProduitRiz = produitRiz[idRiz];
       nomriz = newProduitRiz.nomriz;
       dateplantation = newProduitRiz.dateplantation;
       if (uint(newProduitRiz.region) == 0) {
           region = "ProduitRiz Planter";
       }
       if (uint(newProduitRiz.region) == 1) {
           region = "ProduitRiz Recolter";
       }
       if (uint(newProduitRiz.region) == 2) {
           region = "ProduitRiz Emballer";
       }
       idChamps = newProduitRiz.champs.idChamps;

       nomChamps = newProduitRiz.champs.nomChamps;
       latitudeChamps = newProduitRiz.champs.location.latitude;
       longitudeChamps = newProduitRiz.champs.location.longitude;
       locationAddressChamps = newProduitRiz.champs.location.locationAddress;
   }

   function emballageRiz(uint numSacs, uint noRiz, uint _prix, string nomriz) public
    produitRizExists(noRiz)
    verifyCultivateur(noRiz, Cultivateur.Emballer)
    verifyCaller(produitRiz[noRiz].addresseChamps)
    onlyProducteur {

        SacRiz storage newSacs = sacs[numSacs];
        newSacs.idSac = numSacs;
        newSacs.produitRiz = produitRiz[noRiz];
        newSacs.prix = _prix;
        newSacs.etatRiz = EtatRiz.Packed;
        newSacs.acheteur = emptyAddress;
        newSacs.proprietaireRiz = msg.sender;
        newSacs.nomProducteur = nomriz;

        emit SacRizPacked(sacs[numSacs].idSac);
    }

    function sacForDistributionSale(uint idSac, uint _prix) public payable
    SacRizExists(idSac)
    verifyEtatRiz(idSac, EtatRiz.Packed)
    isPaidEnough(_prix)
    returnExcessChange(idSac)
    onlyDistributeur {

        address distributeurs = msg.sender;

        sacs[idSac].acheteur = distributeurs;
        sacs[idSac].proprietaireRiz.transfer(_prix);
        sacs[idSac].proprietaireRiz = distributeurs;
        sacs[idSac].etatRiz = EtatRiz.ForDistributionSold;

        emit SacRizForDistributionSold(idSac);
    }

    function SacRizShipForRetail(uint idSac, uint _prix) public payable
   SacRizExists(idSac)
   verifyEtatRiz(idSac, EtatRiz.ForDistributionSold)
   isPaidEnough(_prix)
   returnExcessChange(idSac)
   onlyVendeur {

       address vendeurs = msg.sender;

       sacs[idSac].acheteur = msg.sender;
       sacs[idSac].proprietaireRiz.transfer(_prix);
       sacs[idSac].proprietaireRiz = vendeurs;
       sacs[idSac].etatRiz = EtatRiz.ShippedRetail;
   }

   function sacForSale(uint idSac, uint prix) public
    SacRizExists(idSac)
    verifyEtatRiz(idSac, EtatRiz.ShippedRetail)
    verifyCaller(sacs[idSac].proprietaireRiz)
    onlyVendeur {

        sacs[idSac].prix = prix;
        sacs[idSac].etatRiz = EtatRiz.ForSale;

        emit RizSacForSale(idSac);
    }


    function buySacRiz(uint idSac) public payable
    SacRizExists(idSac)
    verifyEtatRiz(idSac, EtatRiz.ForSale)
    isPaidEnough(sacs[idSac].prix)
    returnExcessChange(idSac)
    onlyClient {

        sacs[idSac].acheteur = msg.sender;
        sacs[idSac].etatRiz = EtatRiz.Sold;
        sacs[idSac].proprietaireRiz.transfer(sacs[idSac].prix);

        emit RizSacRizSold(idSac);
    }


    function shipSacRiz(uint idSac) public
    SacRizExists(idSac)
    verifyEtatRiz(idSac, EtatRiz.Sold)
    verifyCaller(sacs[idSac].proprietaireRiz)
    onlyVendeur {

        sacs[idSac].etatRiz = EtatRiz.Shipped;

        emit SacRizShipped(idSac);
    }

    function SacReceived(uint idSac) public
   SacRizExists(idSac)
   verifyEtatRiz(idSac, EtatRiz.Shipped)
   verifyCaller(sacs[idSac].acheteur)
   onlyClient {

       sacs[idSac].proprietaireRiz = sacs[idSac].acheteur;
       sacs[idSac].acheteur = emptyAddress;
       sacs[idSac].etatRiz = EtatRiz.Received;

       emit SacRizReceived(idSac);
   }

   function getSacInfo(uint _idSac) public view
   SacRizExists(_idSac)
   returns (uint idSac, uint prix, address proprietaire, address acheteur, string region, uint idRiz, string nomriz) {
       idSac = _idSac;
       prix = sacs[_idSac].prix;
       proprietaire = sacs[_idSac].proprietaireRiz;
       acheteur = sacs[_idSac].acheteur;

       if(uint(sacs[_idSac].etatRiz) == 0) {
           region = "Sacs de Riz";
       }
       if(uint(sacs[_idSac].etatRiz) == 1) {
           region = "Sacs de Riz pour la Distribution";
       }
       if(uint(sacs[_idSac].etatRiz) == 2) {
           region = "Sacs de Riz expedie au detaillant";
       }
       if(uint(sacs[_idSac].etatRiz) == 3) {
           region = "Sac de Riz a vendre avec detaillant";
       }
       if(uint(sacs[_idSac].etatRiz) == 4) {
           region = "Sacs de Riz vendu au consommateur";
       }
       if(uint(sacs[_idSac].etatRiz) == 5) {
           region = "Sacs de Riz expedie au consommateur";
       }
       if(uint(sacs[_idSac].etatRiz) == 6) {
           region = "Sacs de Riz recue par le consommateur";
       }

       idRiz = sacs[_idSac].produitRiz.idRiz;
       nom = sacs[_idSac].nomProducteur;

   }


}
