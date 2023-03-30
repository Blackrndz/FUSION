/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Configure%20Talent%20Review%20Dashboard%20Options%20-%20Configure%20Boxes.sql $:
 * $Id: Configure Talent Review Dashboard Options - Configure Boxes.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 WITH TMP_RATING AS (SELECT COUNT(RATING_MODEL_ID) AS ROW_LEVEL,RATING_MODEL_ID FROM HRT_RATING_CATEGORIES_VL GROUP BY RATING_MODEL_ID)

SELECT talentRwTemplatesE0.NAME RES_TEMPLATE_NAME
,tmplANALYZOPTNE0.ANALYTIC_VIEW_NAME RES_VIEW_NAME
,(CASE WHEN ANALYTIC_VIEW_MODE = 'XY'
	THEN (SELECT TO_CHAR(ROW_LEVEL) FROM TMP_RATING WHERE RATING_MODEL_ID =(SELECT RATING_MODEL_ID FROM HRR_TMPL_METRIC_CONFIG_Vl WHERE METRIC_CODE  = tmplANALYZOPTNE0.VERTICAL_AXIS_CODE AND DASHBOARD_TMPL_ID = tmplANALYZOPTNE0.DASHBOARD_TMPL_ID))
	ELSE tmplANALYZOPTNE0.VIEW_ROW_COUNT END)  RES_ROWS
,(CASE WHEN ANALYTIC_VIEW_MODE = 'XY'
	THEN (SELECT TO_CHAR(ROW_LEVEL) FROM TMP_RATING WHERE RATING_MODEL_ID =(SELECT RATING_MODEL_ID FROM HRR_TMPL_METRIC_CONFIG_Vl WHERE METRIC_CODE  = tmplANALYZOPTNE0.HORIZONTAL_AXIS_CODE AND DASHBOARD_TMPL_ID = tmplANALYZOPTNE0.DASHBOARD_TMPL_ID))
	ELSE tmplANALYZOPTNE0.VIEW_COLUMN_COUNT END) RES_COLUMNS
,NULL RES_SHOW_HEXADECIMAL_CODE

,tmplANALYZOPTNE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,tmplANALYZOPTNE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,tmplANALYZOPTNE0.CREATED_BY RSC_CREATED_BY
,tmplANALYZOPTNE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRR_DASHBOARD_TMPLS_VL talentRwTemplatesE0
,HRR_TMPL_ANALYTIC_TYPES_VL tmplANALYZOPTNE0
WHERE talentRwTemplatesE0.DASHBOARD_TMPL_ID = tmplANALYZOPTNE0.DASHBOARD_TMPL_ID
ORDER BY talentRwTemplatesE0.NAME,tmplANALYZOPTNE0.ANALYTIC_VIEW_NAME