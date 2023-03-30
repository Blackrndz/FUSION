/* ****************************************************************************
 * $Revision: 74359 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2020-07-20 16:16:20 +0700 (Mon, 20 Jul 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Common%20Options%20for%20Payables%20and%20Procurement%20-%20Manage%20Common%20Options%20for%20Payables%20and%20Proc $:
 * $Id: Manage Common Options for Payables and Procurement - Manage Common Options for Payables and Procurement.sql 74359 2020-07-20 09:16:20Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=FND_AUDIT_CONFIG_METADATA

WITH AUDIT_LIST AS (SELECT * 
	FROM (SELECT VIEW_OBJECT
		,NEW_VALUE
		,ROW_NUMBER() OVER (PARTITION BY VIEW_OBJECT ORDER BY LAST_UPDATE_DATE DESC) R1
		FROM FND_AUDIT_CONFIG_METADATA
		WHERE WEBAPP = 'ORA_FND_AUDIT_POLICY')
	WHERE R1 = 1)

SELECT NVL((SELECT NEW_VALUE
		FROM AUDIT_LIST
		WHERE VIEW_OBJECT = 'ORA_FND_FA_BO')
	,'None') RES_ORACLE_FUSION_APPLICATIONS
,NVL((SELECT NEW_VALUE||DECODE(NEW_VALUE
			,'High',' - All Events'
			,'Medium',' - Some Events'
			,'Low',' - Critical Events Only')
		FROM AUDIT_LIST
		WHERE VIEW_OBJECT = 'ORA_FND_ADF-MDS')
	,'None') RES_PAGES_AND_BUSINESS_OBJECTS
,NVL((SELECT NEW_VALUE||DECODE(NEW_VALUE
			,'High',' - All Events'
			,'Medium',' - Some Events'
			,'Low',' - Critical Events Only')
		FROM AUDIT_LIST
		WHERE VIEW_OBJECT = 'ORA_FND_ESS')
	,'None') RES_ORACLE_ENTERPRISE_SCHEDULI
,NVL((SELECT NEW_VALUE||DECODE(NEW_VALUE
			,'High',' - All Events'
			,'Medium',' - Some Events'
			,'Low',' - Critical Events Only')
		FROM AUDIT_LIST
		WHERE WEBAPP = 'ORA_FND_AUDIT_POLICY'
		AND VIEW_OBJECT = 'ORA_FND_MDS')
	,'None') RES_ORACLE_METADATA_SERVICES
,NVL((SELECT NEW_VALUE||DECODE(NEW_VALUE
			,'High',' - All Events'
			,'Medium',' - Some Events'
			,'Low',' - Critical Events Only')
		FROM AUDIT_LIST
		WHERE VIEW_OBJECT = 'ORA_FND_ODI')
	,'None') RES_ORACLE_DATA_INTEGRATOR
,NVL((SELECT NEW_VALUE||DECODE(NEW_VALUE
			,'High',' - All Events'
			,'Medium',' - Some Events'
			,'Low',' - Critical Events Only')
		FROM AUDIT_LIST
		WHERE VIEW_OBJECT = 'ORA_FND_OPSS')
	,'None') RES_ORACLE_PLATFORM_SECURITY_S
,NVL((SELECT NEW_VALUE||DECODE(NEW_VALUE
			,'High',' - All Events'
			,'Medium',' - Some Events'
			,'Low',' - Critical Events Only')
		FROM AUDIT_LIST
		WHERE VIEW_OBJECT = 'ORA_FND_SOA-MDS')
	,'None') RES_ORACLE_SOA_SUITE

,auditsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,auditsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,auditsE0.CREATED_BY  RSC_CREATED_BY
,auditsE0.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT * 
	FROM FND_AUDIT_CONFIG_METADATA
	WHERE WEBAPP = 'ORA_FND_AUDIT_POLICY'
	AND ROWNUM = 1) auditsE0