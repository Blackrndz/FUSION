/* ****************************************************************************
 * $Revision: 80073 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2023-02-01 17:21:03 +0700 (Wed, 01 Feb 2023) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Learning%20Setup%20-%20External%20Providers%20Adobe%20Connect.sql $:
 * $Id: Manage Learning Setup - External Providers Adobe Connect.sql 80073 2023-02-01 10:21:03Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=WLF_PROVIDER_ACCOUNTS

SELECT 'Adobe Connect' RES_PROVIDER
,provider.ACCOUNT_NAME RES_ADOBE_CONNECT_ACCOUNT_NAME -- Adobe Connect - Account Name
,'' RES_ADOBE_CONNECT_PROVIDER_ACC -- Adobe Connect - Provider Account Number
,provider.DESCRIPTION RES_ADOBE_CONNECT_DESCRIPTION -- Adobe Connect - Description
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_VILT_PROV_STATUS'
    AND LOOKUP_CODE = provider.STATUS 
	) RES_ADOBE_CONNECT_STATUS
,provider.PROVIDER_URL RES_ADOBE_CONNECT_PROVIDER_URL
,provider.USERNAME RES_ADOBE_CONNECT_USER_NAME
,'' RES_ADOBE_CONNECT_PASSWORD
,provider.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,provider.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,provider.CREATED_BY  RSC_CREATED_BY
,provider.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WLF_PROVIDER_ACCOUNTS provider
WHERE provider.PROVIDER_TYPE = 'ORA_ADOBE'