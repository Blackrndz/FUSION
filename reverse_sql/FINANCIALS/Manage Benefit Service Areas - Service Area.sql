/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Service%20Areas%20-%20Service%20Area.sql $:
 * $Id: Manage Benefit Service Areas - Service Area.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT  benSVCAREAEO.NAME  RES_NAME
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = benSVCAREAEO.ORG_UNIT_PRDCT
	AND LOOKUP_TYPE = 'BEN_PRDCT' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_SERVICE_TYPE 
,TO_CHAR(benSVCAREAEO.START_DATE,'DD-MM-YYYY')  RES_SERVICE_AREA_START_DATE
,TO_CHAR(benSVCAREAEO.END_DATE,'DD-MM-YYYY')  RES_SERVICE_AREA_END_DATE


,benSVCAREAEO.LAST_UPDATED_BY 			RSC_LAST_UPDATED_BY
,benSVCAREAEO.LAST_UPDATE_DATE 			RSC_LAST_UPDATE_DATE
,benSVCAREAEO.CREATED_BY 				RSC_CREATED_BY
,benSVCAREAEO.CREATION_DATE 			RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_SVC_AREA benSVCAREAEO
WHERE SYSDATE BETWEEN START_DATE AND NVL(END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
