/* ****************************************************************************
 * $Revision: 61060 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-17 09:40:24 +0700 (Fri, 17 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Application%20Tax%20Options%20-%20Application%20Tax%20Options.sql $:
 * $Id: Manage Application Tax Options - Application Tax Options.sql 61060 2017-02-17 02:40:24Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT BankBranchEO.BANK_NAME RES_BANK
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'HZ_DOMAIN_SUFFIX_LIST'
	AND LOOKUP_CODE   = BankBranchEO.BANK_HOME_COUNTRY
	AND ENABLED_FLAG = 'Y'
    and LANGUAGE = USERENV('LANG')
	) RES_BRANCH_COUNTRY
,BankBranchEO.BANK_BRANCH_NAME RES_BRANCH_NAME
,hz_format_pub.format_address(p_location_id => partySitesE0.LOCATION_ID, p_line_break => ',') RES_ADDRESS
,partySitesE0.PARTY_SITE_NUMBER RES_SITE_NUMBER
,DECODE(partySitesE0.IDENTIFYING_ADDRESS_FLAG,'Y','Yes','No') RES_PURPOSE
,TO_CHAR(partySitesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(partySitesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,partySitesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,partySitesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,partySitesE0.CREATED_BY RSC_CREATED_BY
,partySitesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_BANK_BRANCHES_V BankBranchEO
,HZ_PARTY_SITES partySitesE0
--,HZ_LOCATIONS locationsE0
WHERE BankBranchEO.BRANCH_PARTY_ID = partySitesE0.PARTY_ID
AND partySitesE0.STATUS = 'A'
--AND partySitesE0.LOCATION_ID = locationsE0.LOCATION_ID
ORDER BY BankBranchEO.BANK_BRANCH_NAME
,BankBranchEO.BANK_NAME
,DECODE(partySitesE0.IDENTIFYING_ADDRESS_FLAG,'Y',1,2)
,hz_format_pub.format_address(p_location_id => partySitesE0.LOCATION_ID, p_line_break => ',')