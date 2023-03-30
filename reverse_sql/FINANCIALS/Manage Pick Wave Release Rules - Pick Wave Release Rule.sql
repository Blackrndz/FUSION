/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT WshPickingRules.PICKING_RULE_NAME RES_NAME
,TO_CHAR(WshPickingRules.START_DATE_ACTIVE,'DD-Mon-YYYY HH24:MI:SS') RES_START_DATE
,TO_CHAR(WshPickingRules.END_DATE_ACTIVE,'DD-Mon-YYYY HH24:MI:SS') RES_END_DATE
,WshPickingRules.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,WshPickingRules.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,WshPickingRules.CREATED_BY RSC_CREATED_BY
,WshPickingRules.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,WshPickingRules.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_PICKING_RULES WshPickingRules
ORDER BY WshPickingRules.PICKING_RULE_NAME