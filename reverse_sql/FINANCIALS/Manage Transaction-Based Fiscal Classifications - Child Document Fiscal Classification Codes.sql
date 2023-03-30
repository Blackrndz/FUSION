/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction-Based%20Fiscal%20Classifications%20-%20Child%20Document%20Fiscal%20Classification%20Codes.sql $:
 * $Id: Manage Transaction-Based Fiscal Classifications - Child Document Fiscal Classification Codes.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT (SELECT CONCAT_CLASSIF_CODE
	FROM ZX_FC_CODES_DENORM_VL
	WHERE CLASSIFICATION_ID = fcCodesParentE0.CLASSIFICATION_ID
	) RES_FISCAL_CLASSIFICATION_CODE
,fcCodesParentE0.CLASSIFICATION_CODE RES_PARENT_FISCAL_CLASSIFICATI
,fcCodesE0.CLASSIFICATION_CODE RES_CODE
,fcCodesE0.CLASSIFICATION_NAME RES_NAME
,(SELECT TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_TL
	WHERE TERRITORY_CODE = fcCodesE0.COUNTRY_CODE
	AND LANGUAGE = USERENV('LANG')
	) RES_COUNTRY
,TO_CHAR(fcCodesE0.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(fcCodesE0.EFFECTIVE_TO,'DD-Mon-YYYY') RES_END_DATE
,fcCodesE0.CREATED_BY AS RSC_CREATED_BY
,fcCodesE0.CREATION_DATE AS RSC_CREATION_DATE
,fcCodesE0.LAST_UPDATED_BY AS RSC_LAST_UPDATED_BY
,fcCodesE0.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM ZX_FC_CODES_VL fcCodesE0
,ZX_FC_CODES_VL fcCodesParentE0
WHERE fcCodesE0.CLASSIFICATION_TYPE_CODE = 'DOCUMENT_SUBTYPE'
AND fcCodesE0.PARENT_CLASSIFICATION_ID = fcCodesParentE0.CLASSIFICATION_ID
ORDER BY 1,fcCodesE0.CLASSIFICATION_CODE