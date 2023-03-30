/* ****************************************************************************
 * $Revision: 54943 $:
 * $Author: paul.wakefield $:
 * $Date: 2016-05-04 13:45:23 +0700 (Wed, 04 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Trading%20Community%20Person%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Trading Community Person Lookups - Standard Lookup Type.sql 54943 2016-05-04 06:45:23Z paul.wakefield $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT payDEDUCTYPEO.DEDUCTION_CODE RES_SHORT_NAME
,payDEDUCTYPEO.NAME RES_NAME 
,payDEDCONEO.SEQUENCE RES_SEQUENCE
,(SELECT CONTEXT_NAME FROM FF_CONTEXTS_VL WHERE CONTEXT_ID = payDEDCONEO.CONTEXT_ID) RES_REFERENCE
,DECODE(payDEDCONEO.NAVIGATION_USE,'true','Yes','No') RES_DISPLAY_IN_OVERVIEW

,payDEDCONEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payDEDCONEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payDEDCONEO.CREATED_BY RSC_CREATED_BY
,payDEDCONEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_DEDUCTION_TYPES_VL  payDEDUCTYPEO
,PAY_DED_CONTEXT_USAGES payDEDCONEO
WHERE payDEDUCTYPEO.DEDUCTION_TYPE_ID =  payDEDCONEO.DEDUCTION_TYPE_ID 
AND payDEDCONEO.USAGE_TYPE = 'D'
ORDER BY RES_NAME