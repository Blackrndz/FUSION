/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCATS_VL

SELECT talentRwTemplatesE0.NAME RES_TEMPLATE_NAME
,chartViewsE0.ANALYTIC_VIEW_NAME RES_VIEW_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRR_DEFAULT_VIEW'
    AND LOOKUP_CODE = chartViewsE0.ANALYTIC_VIEW_MODE
    ) RES_VIEW_TYPE
,(CASE
    WHEN chartViewsE0.ANALYTIC_VIEW_MODE = 'XY' THEN
        (SELECT LABEL
            FROM HRR_TMPL_METRIC_CONFIG_VL
            WHERE DASHBOARD_TMPL_ID = chartViewsE0.DASHBOARD_TMPL_ID
            AND METRIC_CODE = chartViewsE0.HORIZONTAL_AXIS_CODE)
    ELSE
        (SELECT LABEL
            FROM HRR_TMPL_METRIC_CONFIG_VL
            WHERE DASHBOARD_TMPL_ID = chartViewsE0.DASHBOARD_TMPL_ID
            AND METRIC_CODE = chartViewsE0.METRIC_CODE)
    END) RES_X_AXIS_OR_SINGLE_RATING
,(CASE
    WHEN chartViewsE0.ANALYTIC_VIEW_MODE = 'XY' THEN
        (SELECT LABEL
            FROM HRR_TMPL_METRIC_CONFIG_VL
            WHERE DASHBOARD_TMPL_ID = chartViewsE0.DASHBOARD_TMPL_ID
            AND METRIC_CODE = chartViewsE0.VERTICAL_AXIS_CODE)
    END) RES_Y_AXIS
,DECODE(chartViewsE0.DEFAULT_VIEW_FLAG,'Y','Yes','No') RES_SET_AS_DEFAULT
,DECODE(chartViewsE0.SUBMIT_BOX_ASGNMNT_FLAG,'Y','Yes','No') RES_SUBMIT_BOX_ASSIGNMENT
,chartViewsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,chartViewsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,chartViewsE0.CREATED_BY RSC_CREATED_BY
,chartViewsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRR_DASHBOARD_TMPLS_VL talentRwTemplatesE0
,HRR_TMPL_ANALYTIC_TYPES_VL chartViewsE0
WHERE talentRwTemplatesE0.DASHBOARD_TMPL_ID = chartViewsE0.DASHBOARD_TMPL_ID
ORDER BY talentRwTemplatesE0.NAME
,chartViewsE0.ANALYTIC_VIEW_NAME