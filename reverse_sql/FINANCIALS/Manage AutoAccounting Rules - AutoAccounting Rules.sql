/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoAccounting%20Rules%20-%20AutoAccounting%20Rules.sql $:
 * $Id: Manage AutoAccounting Rules - AutoAccounting Rules.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT BusinessUnitPEO.BU_NAME RES_BUSINESS_UNIT
,(SELECT entity.MEANING
	FROM FUSION.AR_LOOKUPS entity
	WHERE lookup_type = 'AUTOGL_TYPE'
	AND lookup_code   = RaAccountDefaultsAll.TYPE
	) RES_ACCOUNT_TYPE
,RaAccountDefaultsAll.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,RaAccountDefaultsAll.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,RaAccountDefaultsAll.CREATED_BY  RSC_CREATED_BY
,RaAccountDefaultsAll.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,RaAccountDefaultsAll.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FUSION.FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
,FUSION.RA_ACCOUNT_DEFAULTS_ALL RaAccountDefaultsAll
WHERE BusinessUnitPEO.BU_ID = RaAccountDefaultsAll.ORG_ID
ORDER BY BusinessUnitPEO.BU_NAME