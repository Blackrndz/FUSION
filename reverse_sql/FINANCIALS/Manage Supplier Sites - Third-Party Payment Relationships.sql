/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-10-12  $:
 * $HeadURL:  $:
 * $Id: Manage Supplier Sites - Third-Party Payment Relationships.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=POZ_SUPPLIER_SITES_ALL_M

 
SELECT  DISTINCT
  (select PersonParty.PARTY_NAME 
  from  HZ_PARTIES PersonParty ,HZ_PARTY_SITES PartySitePEO
  where   PersonParty.PARTY_ID = PartySitePEO.PARTY_ID
  and PartySitePEO.PARTY_SITE_ID =  SupplierSiteDEO.PARTY_SITE_ID  )            RES_SUPPLIER,
  SupplierPEO.SEGMENT1                                                          RES_SUPPLIER_NUMBER,
  BusinessUnitPEO.BU_NAME                                                       RES_PROCUREMENT_BU,
  /*SupplierSiteDEO.PARTY_SITE_ID*/SupplierSiteDEO.VENDOR_SITE_CODE             RES_SITE,
 decode(Relat.DEFAULT_RELATIONSHIP_FLAG,'Y','Yes','No')                     RES_DEFAULT,
 (  select PARTY_NAME from HZ_PARTIES PartySitePEO 
    where IDEN_ADDR_PARTY_SITE_ID = Relat.REMIT_TO_ADDRESS_ID )  /*Relat.REMIT_TO_SUPPLIER_ID */  RES_REMIT_TO_SUPPLIER_SUPPLIER,
 /*Relat.VENDOR_SITE_ID*/
 (  select PARTY_NUMBER 
    from HZ_PARTIES PartySitePEO 
    where IDEN_ADDR_PARTY_SITE_ID = Relat.REMIT_TO_ADDRESS_ID )  /*Relat.REMIT_TO_ADDRESS_ID    */    RES_REMIT_TO_SUPPLIER_SUPPLI_0,
 (  select distinct VENDOR_SITE_CODE 
     from POZ_SUPPLIER_SITES_ALL_M PartySite 
     where PartySite.PARTY_SITE_ID = Relat.REMIT_TO_ADDRESS_ID 
     and  PRIMARY_PAY_SITE_FLAG  = 'Y'
     )                                                                          RES_ADDRESS_NAME,
 to_char(Relat.FROM_DATE,'DD-Mon-YYYY')                                         RES_FROM_DATE,
 to_char(Relat.TO_DATE,'DD-Mon-YYYY')                                           RES_TO_DATE,
Relat.DESCRIPTION                                                               RES_DESCRIPTION,
    
 Relat.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,Relat.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Relat.CREATED_BY RSC_CREATED_BY
,Relat.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM POZ_SUPPLIER_SITES_ALL_M SupplierSiteDEO,
  FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO,
  FND_TERRITORIES_VL TerritoryPEO,
  FND_CURRENCIES_VL InvoiceCurrencyPEO,
  FND_CURRENCIES_VL PaymentCurrencyPEO,
  AP_TOLERANCE_TEMPLATES ApInvoiceToleranceTemplates,
  AP_TOLERANCE_TEMPLATES ApServicesToleranceTemplates,
  AP_TERMS_VL ApTermsVl,
  WSH_CARRIERS WshCarriers,
  HZ_PARTIES PartyPEO,
  POZ_SUPPLIER_SITES_ALL_M SupplierSiteDEO_AltPaySite,
  HZ_PARTY_SITES PartySitePEO,
  HZ_LOCATIONS LocationEO,
  AP_LOOKUP_CODES PayGroupLookupPEO,
  WSH_LOOKUPS TransportLookupPEO,
  WSH_LOOKUPS ServiceLevelLookupPEO
  ,IBY_EXTERNAL_PAYEES_ALL IbyExternalPayeesAll
  ,POZ_SUPPLIERS SupplierPEO
  ,POZ_SUP_THIRDPARTY_PAYMENT_REL   Relat
WHERE SupplierSiteDEO.LOCATION_ID          = LocationEO.LOCATION_ID(+)
AND SupplierSiteDEO.PARTY_SITE_ID          = PartySitePEO.PARTY_SITE_ID(+)
AND SupplierSiteDEO.PRC_BU_ID              = BusinessUnitPEO.BU_ID
and  SupplierSiteDEO.PARTY_SITE_ID  = IbyExternalPayeesAll.PARTY_SITE_ID(+)
AND SupplierSiteDEO.COUNTRY_OF_ORIGIN_CODE = TerritoryPEO.TERRITORY_CODE(+)
AND SupplierSiteDEO.INVOICE_CURRENCY_CODE  = InvoiceCurrencyPEO.CURRENCY_CODE(+)
AND SupplierSiteDEO.PAYMENT_CURRENCY_CODE  = PaymentCurrencyPEO.CURRENCY_CODE(+)
AND SupplierSiteDEO.TOLERANCE_ID           = ApInvoiceToleranceTemplates.TOLERANCE_ID(+)
AND SupplierSiteDEO.SERVICES_TOLERANCE_ID  = ApServicesToleranceTemplates.TOLERANCE_ID(+)
AND SupplierSiteDEO.TERMS_ID               = ApTermsVl.TERM_ID(+)
AND SupplierSiteDEO.PAY_GROUP_LOOKUP_CODE  = PayGroupLookupPEO.LOOKUP_CODE(+)
AND PayGroupLookupPEO.LOOKUP_TYPE(+)       = 'PAY GROUP'
AND SupplierSiteDEO.CARRIER_ID             = WshCarriers.CARRIER_ID(+)
AND WshCarriers.CARRIER_ID                 = PartyPEO.PARTY_ID (+)
AND SupplierSiteDEO.MODE_OF_TRANSPORT      = TransportLookupPEO.LOOKUP_CODE(+)
AND TransportLookupPEO.LOOKUP_TYPE(+)      = 'WSH_MODE_OF_TRANSPORT'
AND SupplierSiteDEO.SERVICE_LEVEL          = ServiceLevelLookupPEO.LOOKUP_CODE(+)
AND ServiceLevelLookupPEO.LOOKUP_TYPE(+)   = 'WSH_SERVICE_LEVELS'
AND SupplierSiteDEO.DEFAULT_PAY_SITE_ID    = SupplierSiteDEO_AltPaySite.VENDOR_SITE_ID(+)
AND ('N'                                   = 'N'
OR EXISTS
  (SELECT 1
  FROM PO_AGENT_ACCESSES PoAgents
  WHERE /*PoAgents.agent_id         = :bindLoggedInPersonId
  AND*/ PoAgents.PRC_BU_ID          = BusinessUnitPEO.BU_ID
  AND PoAgents.access_action_code = 'MANAGE_SUPPLIERS'
  AND PoAgents.active_flag        = 'Y'
  AND PoAgents.allowed_flag       = 'Y'
  ))
AND (IbyExternalPayeesAll.SUPPLIER_SITE_ID    IS not NULL )
and SupplierPEO.VENDOR_ID  = SupplierSiteDEO.VENDOR_ID
and Relat.VENDOR_SITE_ID  = SupplierSiteDEO.VENDOR_SITE_ID
--and   SupplierSiteDEO.VENDOR_SITE_CODE   ='BBC'  

ORDER BY  SupplierSiteDEO.VENDOR_SITE_CODE