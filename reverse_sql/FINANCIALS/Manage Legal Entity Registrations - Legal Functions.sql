/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Legal%20Entity%20Registrations%20-%20Legal%20Functions.sql $:
 * $Id: Manage Legal Entity Registrations - Legal Functions.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT
	(SELECT NAME
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = XleRegistrations.SOURCE_ID
	) AS RES_LEGAL_ENTITY
,(SELECT LEGAL_ENTITY_IDENTIFIER
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = XleRegistrations.SOURCE_ID
	) AS RES_LEGAL_ENTITY_IDENTIFIER
,(SELECT name
	FROM XLE_JURISDICTIONS_VL
	WHERE JURISDICTION_ID = XleRegistrations.JURISDICTION_ID
	) AS RES_JURISDICTION
,XleRegistrations.REGISTERED_NAME AS RES_REGISTERED_NAME
,XleRegistrations.REGISTRATION_NUMBER AS RES_REGISTRATION_NUMBER	
,(SELECT meaning
	FROM XLE_LOOKUPS
	WHERE lookup_type = 'XLE_LE_FUNCTION'
	AND lookup_code   = XleRegFunctions.FUNCTION_CODE
	) AS RES_LEGAL_FUNCTION
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = XleRegFunctions.AUTHORITY_ID
	) AS RES_LEGAL_AUTHORITY
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE IDEN_ADDR_PARTY_SITE_ID = XleRegFunctions.AUTHORITY_SITE_ID
	) AS RES_LEGAL_AUTHORITY_ADDRESS
,XleRegFunctions.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,XleRegFunctions.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,XleRegFunctions.CREATED_BY  RSC_CREATED_BY
,XleRegFunctions.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,XleRegistrations.SOURCE_ID RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLE_REGISTRATIONS XleRegistrations
,XLE_REG_FUNCTIONS XleRegFunctions
WHERE XleRegistrations.SOURCE_TABLE = 'XLE_ENTITY_PROFILES'
AND XleRegistrations.REGISTRATION_ID = XleRegFunctions.REGISTRATION_ID
ORDER BY RES_LEGAL_ENTITY