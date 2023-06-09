/* ****************************************************************************
 * $Revision: 72749 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-10-23 15:22:46 +0700 (Wed, 23 Oct 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Availability%20Lookups%20-%20Lookup%20Types.sql $:
 * $Id: Manage Availability Lookups - Lookup Types.sql 72749 2019-10-23 08:22:46Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- REPLACE_HTML_KEYWORD = RES_PLAN_INFO

SELECT cmpPLANEO.PLAN_NAME RES_PLAN
,cmpLOOKUP.DISPLAY_NAME RES_TASK_DISPLAY_NAME
,REPLACE(REPLACE(REPLACE(cmpINTRUCE0.INSTRUCTION_TEXT,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#') RES_PLAN_INFO

,cmpINTRUCE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cmpINTRUCE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cmpINTRUCE0.CREATED_BY RSC_CREATED_BY
,cmpINTRUCE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT * FROM CMP_LOOKUP_USAGES_VL WHERE ATTRIBUTE_NAME = 'CMP_CWB_WORKSHEET_TABS') cmpLOOKUP
,(SELECT PLAN_ID,PLAN_NAME FROM CMP_PLANS_VL WHERE COMP_TYPE = 'CWB') cmpPLANEO
,CMP_INSTRUCTIONS_VL cmpINTRUCE0
WHERE cmpPLANEO.PLAN_ID = cmpLOOKUP.KEY_VALUE
AND cmpLOOKUP.KEY_VALUE = cmpINTRUCE0.INSTRUCTION_KEY
AND cmpLOOKUP.ATTRIBUTE_VALUE = cmpINTRUCE0.KEY_TYPE
AND (cmpLOOKUP.DISPLAY_NAME IS NOT NULL
		OR cmpLOOKUP.ORDER_NUM IS NOT NULL
		OR cmpLOOKUP.TEXT_VALUE1 IS NOT NULL)
ORDER BY cmpPLANEO.PLAN_NAME,cmpLOOKUP.DISPLAY_NAME


