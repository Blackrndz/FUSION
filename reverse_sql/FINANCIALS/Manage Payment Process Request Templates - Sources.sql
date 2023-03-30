/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=AP_PAYMENT_TEMPLATES
 
SELECT apTemplatesE0.TEMPLATE_NAME RES_NAME
,DECODE(apTemplatesE0.SOURCE_GROUP_OPTION,'ALL','All','SPECIFY','Specific','EXCLUDE','Exclude') RES_OPTION_SOURCES
,(SELECT MEANING
	FROM AP_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'SOURCE'
	AND LOOKUP_CODE = apSourceGroupsE0.INVOICE_SOURCE_CODE
	) RES_SOURCE
,apSourceGroupsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,apSourceGroupsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,apSourceGroupsE0.CREATED_BY RSC_CREATED_BY
,apSourceGroupsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AP_PAYMENT_TEMPLATES apTemplatesE0
,AP_SOURCE_GROUP apSourceGroupsE0
WHERE apTemplatesE0.TEMPLATE_ID = apSourceGroupsE0.TEMPLATE_ID
ORDER BY apTemplatesE0.TEMPLATE_NAME,3