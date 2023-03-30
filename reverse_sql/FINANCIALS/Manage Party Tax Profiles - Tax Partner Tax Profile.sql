/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT hzparty.party_name RES_TAX_PARTNER_NAME
,fnd.meaning RES_SUBSCRIPTION_TYPE
,ptp.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ptp.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ptp.CREATED_BY RSC_CREATED_BY
,ptp.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_PARTY_TAX_PROFILE ptp
,HZ_PARTIES hzparty
,FND_LOOKUPS fnd
WHERE ptp.party_type_code      = 'TAX_PARTNER'
AND ptp.PARTY_ID           = hzparty.PARTY_ID
AND ptp.PROVIDER_TYPE_CODE = fnd.lookup_code
AND fnd.Lookup_type        = 'ZX_PROVIDER_TYPE'
ORDER BY hzparty.party_name