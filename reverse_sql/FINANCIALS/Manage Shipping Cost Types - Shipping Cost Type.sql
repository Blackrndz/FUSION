/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT WshFreightCostTypes.FREIGHT_COST_NAME RES_NAME
,WshFreightCostTypes.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'WSH_FREIGHT_COST_TYPE'
	AND LOOKUP_CODE = WshFreightCostTypes.FREIGHT_COST_TYPE_CODE
	)RES_CATEGORY
,WshFreightCostTypes.CURRENCY_CODE RES_CURRENCY
,WshFreightCostTypes.AMOUNT RES_AMOUNT
,TO_CHAR(WshFreightCostTypes.START_DATE_ACTIVE,'DD-Mon-YYYY HH24:MI:SS') RES_START_DATE
,TO_CHAR(WshFreightCostTypes.END_DATE_ACTIVE,'DD-Mon-YYYY HH24:MI:SS') RES_END_DATE
,WshFreightCostTypes.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,WshFreightCostTypes.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,WshFreightCostTypes.CREATED_BY RSC_CREATED_BY
,WshFreightCostTypes.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_FREIGHT_COST_TYPES WshFreightCostTypes
ORDER BY WshFreightCostTypes.FREIGHT_COST_NAME