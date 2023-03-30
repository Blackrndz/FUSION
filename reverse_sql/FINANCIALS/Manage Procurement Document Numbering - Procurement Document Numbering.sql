/* ****************************************************************************
* $Revision: 59053 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-20 13:59:22 +0700 (Wed, 19 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Time%20Shift.sql $:
* $Id: Manage Procurement Document Numbering - Procurement Document Numbering.sql 59053 2016-10-19 06:59:22Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT
(select DocumentTypeLookupCodePEO.DISPLAYED_FIELD
      from PO_LOOKUP_CODES DocumentTypeLookupCodePEO
      WHERE DocumentTypeLookupCodePEO.LOOKUP_TYPE  = 'PO_NUMBERING_DOC_TYPES'
      AND DocumentTypeLookupCodePEO.LOOKUP_CODE     = PoUniqueIdentifierEO.TABLE_NAME )       							RES_DOCUMENT_TYPE,
DeterminantTypeLookupCodePEO.DISPLAYED_FIELD RES_DETERMINANT_TYPE,
NVL(BusinessUnitPEO.BU_NAME,LegalEntityPEO.NAME)                                                                      RES_DETERMINANT_VALUE,
PoUniqueIdentifierEO.PREFIX                           RES_PREFIX,
(CURRENT_MAX_UNIQUE_IDENTIFIER + 1)                   RES_NEXT_NUMBER,
PoUniqueIdentifierEO.SUFFIX                           RES_SUFFIX,
PoUniqueIdentifierEO.MINIMUM_DIGITS                   RES_MINIMUM_DIGITS,
 NVL(PoUniqueIdentifierEO.PREFIX|| LPAD((CURRENT_MAX_UNIQUE_IDENTIFIER + 1), PoUniqueIdentifierEO.MINIMUM_DIGITS, '0') ||  PoUniqueIdentifierEO.SUFFIX ,(CURRENT_MAX_UNIQUE_IDENTIFIER + 1))  RES_PREVIEW
,PoUniqueIdentifierEO.LAST_UPDATED_BY               RSC_LAST_UPDATED_BY
,PoUniqueIdentifierEO.LAST_UPDATE_DATE              RSC_LAST_UPDATE_DATE
,PoUniqueIdentifierEO.CREATED_BY                    RSC_CREATED_BY
,PoUniqueIdentifierEO.CREATION_DATE                 RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,(CASE
	WHEN PoUniqueIdentifierEO.BU_ID <> -1 THEN
		PoUniqueIdentifierEO.BU_ID
	END) RSC_BUSINESS_UNIT_ID
,(CASE
	WHEN PoUniqueIdentifierEO.LE_ID <> -1 THEN
		PoUniqueIdentifierEO.LE_ID
	END) RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PO_UNIQUE_IDENTIFIER_CONT_ALL PoUniqueIdentifierEO
,FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
,XLE_ENTITY_PROFILES LegalEntityPEO
,PO_LOOKUP_CODES DeterminantTypeLookupCodePEO
WHERE  PoUniqueIdentifierEO.TABLE_NAME          <> 'POZ_SUPPLIERS'
AND PoUniqueIdentifierEO.bu_id                = BusinessUnitPEO.bu_id(+)
AND PoUniqueIdentifierEO.LE_ID                = LegalEntityPEO.legal_entity_id(+)
AND DeterminantTypeLookupCodePEO.LOOKUP_TYPE = 'PO_DETERMINANT_TYPES'
AND DeterminantTypeLookupCodePEO.LOOKUP_CODE  = PoUniqueIdentifierEO.DETERMINANT_TYPE
ORDER BY RES_DOCUMENT_TYPE 
,UPPER(BusinessUnitPEO.BU_NAME)
,UPPER(LegalEntityPEO.NAME)