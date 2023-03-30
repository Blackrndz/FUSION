/* ****************************************************************************
 * $Revision: 53539 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-15 15:09:39 +0700 (Tue, 15 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Configure%20Supplier%20Registration%20-%20Configure%20Supplier%20Registration.sql $:
 * $Id: Configure Supplier Registration - Configure Supplier Registration.sql 53539 2016-03-15 08:09:39Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=POZ_SUPPLIER_ENTITY_CONFIG
 
/*This SQL is not exist in Oracle Fusion version 9*/

SELECT PozLookupPEO.DISPLAYED_FIELD RES_SUPPLIER_PROFILE
,NVL((SELECT MEANING 
	FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'ORA_POZ_CONF_SUP_PROF_CR_APP'
	AND LOOKUP_CODE = SupplierEntityConfigEO.CHANGE_MGMT_PROSPECTIVE
	AND LANGUAGE = USERENV('LANG')
	),'Not Applicable') RES_SUPPLIER_REGISTRATION_PROS
,NVL((SELECT MEANING 
	FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'ORA_POZ_CONF_SUP_PROF_CR_APP'
	AND LOOKUP_CODE = SupplierEntityConfigEO.CHANGE_MGMT_SPEND_AUTH
	AND LANGUAGE = USERENV('LANG')
	),'Not Applicable') RES_SUPPLIER_REGISTRATION_SPEN
,SupplierEntityConfigEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,SupplierEntityConfigEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,SupplierEntityConfigEO.CREATED_BY  RSC_CREATED_BY
,SupplierEntityConfigEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM POZ_SUPPLIER_ENTITY_CONFIG SupplierEntityConfigEO
,POZ_LOOKUP_CODES PozLookupPEO
WHERE (SupplierEntityConfigEO.CHANGE_MGMT_PROSPECTIVE IS NOT NULL
OR SupplierEntityConfigEO.CHANGE_MGMT_SPEND_AUTH IS NOT NULL)
AND SupplierEntityConfigEO.SUPPLIER_PROFILE_ENTITY = PozLookupPEO.LOOKUP_CODE
AND PozLookupPEO.LOOKUP_TYPE = 'ORA_POZ_SUPPLIER_ENTITY'
ORDER BY PozLookupPEO.DISPLAY_SEQUENCE