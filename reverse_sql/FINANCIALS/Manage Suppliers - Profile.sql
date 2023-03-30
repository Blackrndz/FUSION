/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-10-11  $:
 * $HeadURL:  $:
 * $Id: Manage Suppliers - Profile.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT
  /*+ FIRST_ROWS(10) */
  PartyPEO.PARTY_NAME                                                           RES_SUPPLIER,
  SupplierPEO.SEGMENT1                                                          RES_SUPPLIER_NUMBER,
   SupplierPEO.LAST_UPDATED_BY  		RSC_LAST_UPDATED_BY
  ,SupplierPEO.LAST_UPDATE_DATE  	RSC_LAST_UPDATE_DATE
  ,SupplierPEO.CREATED_BY  			RSC_CREATED_BY
  ,SupplierPEO.CREATION_DATE  		RSC_CREATION_DATE
  ,null 								RSC_LEDGER_ID
  ,null 				  RSC_CHART_OF_ACCOUNTS_ID
  ,null 					RSC_BUSINESS_UNIT_ID
  ,null						RSC_LEGAL_ENTITY_ID
  ,null 					RSC_ORGANIZATION_ID
  ,null 					RSC_BUSINESS_GROUP_ID
  ,null            RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM POZ_SUPPLIERS SupplierPEO,
  HZ_PARTIES PartyPEO,
  HZ_ADDTNL_PARTY_NAMES AdditionalPartyNamePEO,
  HZ_ADDTNL_PARTY_NAMES AliasPEO,
  POZ_LOOKUP_CODES PoLookupPEO,
  POZ_SUPPLIERS ParentSupplierPEO,
  HZ_PARTIES ParentPartyPEO,
  AP_INCOME_TAX_TYPES ApIncomeTaxTypes,
  POZ_LOOKUP_CODES VndTypeLookupPEO,
  POZ_LOOKUP_CODES TaxOrgTypePozLookupEO,
  POZ_SUPPLIERS_PII SupplierPiiEO,
  POZ_SUPPLIER_REGISTRATIONS SupplierRegistrationsPEO,
  ZX_PARTY_TAX_PROFILE PartyTaxProfileGenericPEO,
  FND_TERRITORIES_VL TerritoryPEO,
  FND_TERRITORIES_VL TerritoryPEO1,
  POZ_LOOKUP_CODES BusRelationshipLookupPEO,
  POZ_LOOKUP_CODES CreationSourceLookupPEO,
  POZ_LOOKUP_CODES SpendAuthLookupPEO,
  POZ_SPEND_AUTH_REQUESTS SpendAuthRequestPEO
WHERE SUPPLIERPEO.PARTY_ID                    = PARTYPEO.PARTY_ID
AND SpendAuthRequestPEO.VENDOR_ID (+)         = SupplierPEO.VENDOR_ID
AND SpendAuthRequestPEO.CURRENT_FLAG(+)       ='Y'
AND ALIASPEO.PARTY_ID (+)                     =PARTYPEO.PARTY_ID
AND ALIASPEO.PARTY_NAME_TYPE (+)              = 'ALIAS'
AND ADDITIONALPARTYNAMEPEO.PARTY_ID (+)       =PARTYPEO.PARTY_ID
AND ADDITIONALPARTYNAMEPEO.PARTY_NAME_TYPE (+)= 'PHONETIC'
AND (
  CASE
    WHEN SYSDATE >= NVL(SUPPLIERPEO.START_DATE_ACTIVE, SYSDATE-1)
    AND SYSDATE   < NVL(SUPPLIERPEO.END_DATE_ACTIVE, SYSDATE  +1)
    THEN 'ACTIVE'
    ELSE 'INACTIVE'
  END)                                           = POLOOKUPPEO.LOOKUP_CODE
AND POLOOKUPPEO.LOOKUP_TYPE                      = 'POZ_STATUS'
AND SUPPLIERPEO.PARENT_VENDOR_ID                 = PARENTSUPPLIERPEO.VENDOR_ID(+)
AND SUPPLIERPEO.PARENT_PARTY_ID                  = PARENTPARTYPEO.PARTY_ID(+)
AND PartyPEO.PARTY_TYPE                          = 'ORGANIZATION'
AND ADDITIONALPARTYNAMEPEO.STATUS_FLAG (+)       = 'A'
AND ALIASPEO.STATUS_FLAG (+)                     ='A'
AND APINCOMETAXTYPES.INCOME_TAX_TYPE(+)          = SUPPLIERPEO.TYPE_1099
AND VndTypeLookupPEO.LOOKUP_CODE(+)              = SUPPLIERPEO.VENDOR_TYPE_LOOKUP_CODE
AND VndTypeLookupPEO.LOOKUP_TYPE(+)              = 'POZ_VENDOR_TYPE'
AND TaxOrgTypePozLookupEO.LOOKUP_CODE(+)         = SUPPLIERPEO.ORGANIZATION_TYPE_LOOKUP_CODE
AND TaxOrgTypePozLookupEO.LOOKUP_TYPE(+)         = 'POZ_ORGANIZATION_TYPE'
AND SUPPLIERPEO.VENDOR_ID                        = SupplierPiiEO.VENDOR_ID (+)
AND SUPPLIERPEO.PARTY_ID                         = SupplierRegistrationsPEO.VENDOR_PARTY_ID (+)
AND PartyTaxProfileGenericPEO.PARTY_TYPE_CODE(+) = 'THIRD_PARTY'
AND PartyTaxProfileGenericPEO.PARTY_ID (+)       =PARTYPEO.PARTY_ID
AND SupplierPEO.TAXPAYER_COUNTRY                 = TerritoryPEO.TERRITORY_CODE (+)
AND PartyTaxProfileGenericPEO.COUNTRY_CODE       = TerritoryPEO1.TERRITORY_CODE (+)
AND BusRelationshipLookupPEO.LOOKUP_CODE(+)      = SUPPLIERPEO.BUSINESS_RELATIONSHIP
AND BusRelationshipLookupPEO.LOOKUP_TYPE(+)      = 'ORA_POZ_BUSINESS_RELATIONSHIP'
AND SpendAuthLookupPEO.LOOKUP_CODE(+)            = SupplierPEO.SPEND_AUTH_REVIEW_STATUS
AND SpendAuthLookupPEO.LOOKUP_TYPE(+)            = 'ORA_POZ_SPEND_AUTH_REV_STATUS'
AND CreationSourceLookupPEO.LOOKUP_CODE(+)       = SUPPLIERPEO.CREATION_SOURCE
AND CreationSourceLookupPEO.LOOKUP_TYPE(+)       = 'POZ_CREATION_SOURCE'
ORDER BY UPPER(PARTYPEO.PARTY_NAME)


