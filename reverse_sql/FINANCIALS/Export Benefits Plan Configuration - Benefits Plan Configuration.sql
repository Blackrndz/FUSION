/* ****************************************************************************
 * $Revision: 56510 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-06 09:21:36 +0700 (Wed, 06 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/Backup%20Trunk/reverse_sql/FINANCIALS/Manage%20Lifecycle%20Phases%20-%20Manage%20Lifecycle%20Phases.sql $:
 * $Id: Manage Lifecycle Phases - Lifecycle Phases.sql 56510 2016-07-06 02:21:36Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT exportsE0.NAME RES_EXPORT_NAME
,exportsE0.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'BEN_PL_COPY_TYP'
	AND LOOKUP_CODE = exportsE0.COMP_OBJ_TYPE
	) RES_EXPORT_TYPE
,(CASE
	WHEN exportsE0.COMP_OBJ_TYPE = 'ELIG' THEN
		(SELECT NAME
			FROM BEN_ELIGY_PRFL
			WHERE SYSDATE BETWEEN START_DATE AND END_DATE
			AND ELIGY_PRFL_ID = exportsE0.ELIGY_PRFL_ID)
	WHEN exportsE0.COMP_OBJ_TYPE = 'PGM' THEN
		(SELECT NAME
			FROM BEN_PGM_F
			WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
			AND PGM_ID = exportsE0.PGM_ID)
	WHEN exportsE0.COMP_OBJ_TYPE = 'PLN' THEN
		(SELECT NAME
			FROM BEN_PL_F
			WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
			AND PL_ID = exportsE0.PL_ID)
	END) RES_EXPORT_TYPE_VALUE
,exportsE0.last_updated_by  AS RSC_LAST_UPDATED_BY
,exportsE0.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,exportsE0.CREATED_BY  RSC_CREATED_BY
,exportsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,exportsE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  
FROM BEN_PL_COPY_PARAMS exportsE0
WHERE exportsE0.TYPE = 'EXPORT'
ORDER BY exportsE0.NAME