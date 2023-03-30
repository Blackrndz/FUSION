/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT apTemplatesE0.TEMPLATE_NAME RES_NAME
,DECODE(apTemplatesE0.OU_GROUP_OPTION,'ALL','All','PAYMENT','Payment','INVOICE','Invoice') RES_OPTION_BUSINESS_UNITS
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = apOuGroupsE0.ORG_ID
	) RES_BUSINESS_UNITS
,apOuGroupsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,apOuGroupsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,apOuGroupsE0.CREATED_BY RSC_CREATED_BY
,apOuGroupsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,apOuGroupsE0.ORG_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AP_PAYMENT_TEMPLATES apTemplatesE0
,AP_OU_GROUP apOuGroupsE0
WHERE apTemplatesE0.TEMPLATE_ID = apOuGroupsE0.TEMPLATE_ID
ORDER BY apTemplatesE0.TEMPLATE_NAME,3